#!/usr/bin/perl
use File::Copy;

# Last update: added auto-creation of some source dirs, probably not all!!

# $runlist = $ARGV[0];     # Run list to analyze
# $listtype = $ARGV[1];    # Controls if run list holds single column of data
                         # runs (0) or two columns: data run / flasher run (1)
$version = $ARGV[0];     # vegas version to use, assumes prefix "vegas-"
$sourcename = $ARGV[1];  # Name of the source we're analyzing
#$options = $ARGV[3];     # Name of file listing key options for analysis
# $offsets = $ARGV[4];     # LT offsets available: "050" or "all"
$stagecode = $ARGV[2];   # Stages to run the analysis on
#  The stage code string is currently 8 characters long
#  0 - run stage 1? 0=no, 1=yes
#  1 - run stage 2? 0=no, use existing regular analysis; 1=yes; 2=hfit; 4=no, use existing hfit analysis
#  2 - run stage 4? 0=no, 1=geo, 2=disp_old, 3=disp_new, 4=mix
#  3 - run stage 5 regular? 0=no, 1=yes
#  4 - run stage 5 combined? 0=no, 1=yes
#  5 - write calibrated events at st2? 0=no, 1=yes
#  6 - cuts to run at st4? 0=soft, 1=med, 2=hard, 3=all
#  7 - epoch of data 4=V4, 5=V5, 6=V6
                         # 
                         # 
#@epochs=("oa", "na", "ua");
@epochs=("na");
#@wobbles=("000", "025", "050", "075", "100", "125", "150", "175", "200");
@wobbles=("000", "025", "050", "075", "100", "125", "150", "175", "200");
#@atms=("21", "22");
@atms=("21");
#@Zeniths=("00", "20", "30", "35", "40", "45", "50", "55", "60", "65");
@Zeniths=("20","45", "50", "55", "60", "65");
#@Zeniths=("20");
#@noises=("100", "150", "200", "250", "300", "350", "400", "490", "605", "730", "870");
@noises=("350", "400");

$dbhost = $ENV{'VDBHOST'};

# Set up paths to key directories and files on tehanu.
$scriptdir = "/a/home/tehanu/".$ENV{'USER'}."/Analysis/scripts";
$calibscript = "goCal.cmd";
$paramscript = "goPar.cmd";
$rawtmpdir = "/a/data/tehanu/RawTmp";
$OridRaw="/a/data/vetch/Ori/simulation/allSims";
$SimdRaw="/a/data/ged/dribeiro/CrabSim/2_5_4";
$alreadyRunFlashers = "/home/".$ENV{'USER'}."/Analysis/Jobs/alreadyRunFlashers.txt";
$flasherRawLocationFile =
    "/home/".$ENV{'USER'}."/Analysis/Jobs/flasherRawLocationFile.txt";
$flasherOutLocationFile =
    "/home/".$ENV{'USER'}."/Analysis/Jobs/flasherOutLocationFile.txt";
$dataRawLocationFile =
    "/home/".$ENV{'USER'}."/Analysis/Jobs/dataRawLocationFile.txt";
$lndir = "/a/data/tehanu/".$ENV{'USER'}."/".$sourcename."/".$version;
$timeCuts = "/a/home/tehanu/".$ENV{'USER'}."/Analysis/Cuts/timeCuts.txt";

$tehanuFlashers = "/a/data/tehanu/".$ENV{'USER'}."/Flasher/".$version;
unless ( -d $tehanuFlashers ) {
    mkdir $tehanuFlashers or die "Cannot create directory $tehanuFlashers: \'$!\'";
}

# Set up the paths on the analysis/storage servers.
@servers = ( "ged", "serret", "vetch" );
$nServ = 3;
for $server (@servers) {
    $raw1 = "/a/data/".$server."/Raw/Flasher";
    unless ( -d $raw1 ) {
	mkdir -p $raw1 or die "Cannot create directory $raw1";
    }
    @fraws = ( @fraws, $raw1 );
    $out1 = "/a/data/".$server."/".$ENV{'USER'}."/Flasher/".$version;
    unless ( -d $out1 ) {
	mkdir -p $out1 or die "Cannot create directory $out1: \'$!\'";
    }
    unless ( -d "$out1/Log" ) {
	mkdir -p "$out1/Log" or die "Cannot create directory $out1/Log: \'$!\'";
    }
    @fouts = ( @fouts, $out1 );
    $raw1 = "/a/data/".$server."/Raw/".$sourcename;
    #print $raw1."\n";
    unless ( -d $raw1 ) {
	mkdir -p $raw1 or die "Cannot create directory $raw1";
    }
    @draws = ( @draws, $raw1 );
    $out1 = "/a/data/".$server."/".$ENV{'USER'}."/".$sourcename;
    unless ( -d $out1 ) {
	mkdir -p $out1 or die "Cannot create directory $out1";
    }
    $out1 = "/a/data/".$server."/".$ENV{'USER'}."/".$sourcename."/".$version;
    unless ( -d $out1 ) {
	mkdir -p $out1 or die "Cannot create directory $out1";
    }
    unless ( -d "$out1/Log" ) {
	mkdir -p "$out1/Log" or die "Cannot create directory $out1/Log";
    }
    @douts = ( @douts, $out1 );
}

# Make sure critical directories exist.
$out1 = "/data/".$ENV{'USER'}."/".$sourcename;
unless ( -d $out1 ) {
    mkdir -p  $out1 or die "Cannot create directory $out1";
}
unless ( -d $lndir ) {
    mkdir -p  $lndir or die "Cannot create directory $lndir";
}
unless ( -d "$lndir/Log" ) {
    mkdir -p "$lndir/Log" or die "Cannot create directory $lndir/Log";
}



# Loop over the runlist, building up lists of paths to the runs and flashers
# in the database, as well as destinations to write the cvbf files locally
# and a paired data/flasher run list. Also use the date to determine if the 
# LT and DT should be summer or winter. For now, assuming ua.
## druns         - array of run numbers
## fruns         - array of flasher run numbers - entries may repeat since correspond to data runs
## drawfiles     - array of data cvbf file paths (local)
## frawfiles     - array of flasher cvbf file paths (local)
## foutfiles     - array of flasher output file paths (local)
## darchivefiles - array of data cvbf file paths (archive)
## farchivefiles - array of flasher cvbf file paths (archive)
## auto_lt       - array of lookup tables to use with each run
## auto_dt       - array of disp tables to use with each run

## In loop for each run: for a given list type (if statement for each) , get the groupid and flasherRun numbers with the mysql commands
$naptime=2;
$iii=0;
foreach $epoch (@epochs) 
{
  foreach $wobble (@wobbles)
  {
    foreach $atm (@atms)
    {
      foreach $zenith (@Zeniths)
      {
        foreach $noise (@noises)
        {
        $dataRun="Oct2012_".$epoch."_ATM".$atm."_vegasv250rc5_7samples_".$zenith."deg_".$wobble."wobb_".$noise."noise";
        chomp($dataRun);
        chomp( $flasherRun );
        @druns = ( @druns, $dataRun );
        @fruns = ( @fruns, $flasherRun );
        #Organize run directories within proper server    
        $serverIndex = $iii % $nServ;
        #$draws="/a/data/vetch/Ori/simulation/allSims";
        $drawfile=$draws[$serverIndex]."/".$dataRun.".root";
        #$drawfile=$SimdRaw."/".$dataRun.".root";
        @drawfiles = ( @drawfiles, $drawfile );
        $tdrawfile=$rawtmpdir."/".$dataRun.".root";
        @tdrawfiles = ( @tdrawfiles, $tdrawfile );

        # Organize paths to flasher and raw files/temps to directories, with the right filename
        $trawfile=$rawtmpdir."/".$flasherRun.".root";
        @trawfiles = ( @trawfiles, $trawfile );

        $frawfile=$fraws[$serverIndex]."/".$flasherRun.".root";
        @frawfiles = ( @frawfiles, $frawfile );

        $foutfile=$fouts[$serverIndex]."/".$flasherRun.".root";
        @foutfiles = ( @foutfiles, $foutfile );

        $farchivefile="/veritas/data/d".$flasherDate."/".$flasherRun.".root";
        @farchivefiles = ( @farchivefiles, $farchivefile );

        $darchivefile="/veritas/data/d".$dataDate."/".$dataRun.".root";
        @darchivefiles = ( @darchivefiles, $darchivefile );

        $Sarchivefile="/veritas/upload/OAWG/stage2/vegas2.5/Oct2012_".$epoch."_ATM".$atm."/".$zenith."_deg/".$dataRun.".root";
        @Sarchivefiles = ( @Sarchivefiles, $Sarchivefile );

        $extrabit="";

        # Extra bits need for some tables, based on date
        if ( $wobble eq "050" ) { # Choice of offset - only applies to LT
          $offs = "050wobb";      # at present !!!
          }
        else {
          $offs = "allOffsets";
          if ( $epoch eq "ua" ) { # fix for some V6 tables
            $extrabit = "_noise150fix";
            }
          elsif ( $epoch eq "na" ) { # fix for V5 tables
            $extrabit = "_v1";
          }
        }

        # Set lookup tables, first checking what kind of analysis specific in command
       
        if ( (substr($stagecode,1,1) eq '2') || ( substr($stagecode,1,1) eq '4') ) { # HFit lookup tables
          $alt = "/a/data/tehanu/ap3115/LTs/vegas-2.5/lt_Oct2012_".$epoch."_ATM".$atm."_7samples_hfit_vegasv251_050wobb_LZA.root";
          }
        else { # regular lookup tables
          $alt = "/a/data/tehanu/ap3115/LTs/vegas-2.5/lt_Oct2012_".$epoch."_ATM".$atm."_7samples_vegasv250rc5_".$offs."_LZA".$extrabit.".root";
          #	$alt = "/a/data/tehanu/ap3115/LTs/vegas-2.5/lt_Oct2012_ua_ATM21_7samples_vegasv250rc5_050wobb_LZA.root";
          #	$adt = "/a/data/tehanu/ap3115/DTs/vegas-2.5/rc4/dt_Oct2012_ua_ATM21_7samples_vegasv250rc4_050wobb_LZA.root";
          #	$alt = "/a/data/tehanu/ap3115/LTs/vegas-2.5/lt_Oct2012_ua_ATM22_7samples_vegasv250rc5_050wobb_LZA.root";
          #	$adt = "/a/data/tehanu/ap3115/DTs/vegas-2.5/rc4/dt_Oct2012_ua_ATM22_7samples_vegasv250rc4_050wobb_LZA.root";
          }
       
        if ( substr($stagecode,2,1) eq '1') { #geo - no table necessary
          $adt = ""; 
          }
        elsif ( substr($stagecode,2,1) eq '2'){ #disp old - old table
          $adt = "/a/data/tehanu/humensky/DTs/vegas-2.5/dt_Oct2012_".$epoch."_ATM".$atm."_7samples_vegasv250rc5_050wobb_LZA.root"; 
          }
        elsif ( substr($stagecode,2,1) eq '3'){ #disp new
          $adt = "/a/data/tehanu/dribeiro/DTs/TMVA_Disp.xml"; #need this for disp_new
          }
        else{
          }
        @auto_lt = (@auto_lt, $alt);
        @auto_dt = (@auto_dt, $adt);

        @seri = ( @seri, $iii );

        print $alt."\n";
        print $adt."\n";
        print $dataRun."\n".$drawfile."\n".$frawfile."\n";
        print $iii."\t".$serverIndex."\n\n";

        # Increment index
        $iii += 1;

        } #noise
      } # zenith
    }# atm
  }# wobble
}# epoch
$ntot = $iii; # total number of runs in list.
print "Dealing with ".$iii." runs\n";

###############################################################################
###############################################################################
# Download data runs and submit their analysis jobs.
# Loop over data runs, checking whether they are already available or need to be downloaded.
# If needed, download them. Then process them. 
###############################################################################
###############################################################################
for ( $i=0; $i<$ntot; $i++ ) {
  $si = $i % $nServ; # server index - brief name (% does remainder, so this is the next sequential server index per run)
  print $i." server number: ".$si." (".$servers[$si].")\n";
  $drun = $druns[$i];
  print "Data basename: ".$drun."\n";
  $fileSize=0;
  # Check if it's already downloaded.
  $foundRaw = 0;
  $possible=0;
  for ( $serverIndex=0; $serverIndex<3; $serverIndex++ )
  {
    if( -e $OridRaw."/".$drun.".root" )
    {
      $check = $OridRaw."/".$drun.".root";
      print "Found in ".$OridRaw."\n";
      $possible=1;
    }
    elsif ( -e $SimdRaw."/".$drun.".root" )
    {
      $check = $SimdRaw."/".$drun.".root";
      print "Found in ".$SimdRaw."\n";
      $possible=1;
    }
    elsif ( -e $draws[$serverIndex]."/".$drun.".root") 
    {
      $check = $draws[$serverIndex]."/".$drun.".root";
      print "Found in ".$draws[$serverIndex]."\n";
      $possible=1;
    }
    elsif ( -e $drawfiles[$i]) 
    {
      $check = $drawfiles[$i];
      print "Found in ".$drawfiles[$i]."\n";
      $possible=1;
    }
    else
    {
      print "Not found in ".$draws[$serverIndex]." nor the simulation directories. \n";
      $possible=0;
    }

    if ($possible gt 0){
      #print $check."\n";
      chomp($checkln = `readlink -e $check`);
      print "Checking real file ".$checkln."\n";
      if ( -e $checkln ) 
      {
        $foundRaw = 1;
        $command="ls -l ".$checkln;
        #print $command."\n";
        chomp( $fileInfo = `$command` );
        @fileInfo = split /\s+/, $fileInfo;
        $fileSize = $fileInfo[4];
        #$si = $serverIndex;
        #$serverIndex=$si;
        #$drawfiles[$i] = $checkln;
        #print "\n".$servers[$si]."\n";
        #$lncommand="ln -f -s $checkln /a/data/$servers[$serverIndex]/$ENV{'USER'}/${sourcename}/${version}/${drun}s2.root";
        #print $lncommand."\n";
        #system $lncommand;
        #$lncommand="ln -f -s $checkln /a/data/tehanu/$ENV{'USER'}/${sourcename}/${version}/${drun}s2.root";
        #print $lncommand."\n";
        #system $lncommand;
        last;
      }
      else 
      {
        $fileSize = 0;
        print "file missing \n";
      }
    }
    #print "  local size = ".$fileSize."\n";
  }
  # Check remote file size
  $command="bbftp -w 50065 -m -p 1 -u bbftp -V -S -e \"stat ".$Sarchivefiles[$i].
  "\" gamma1.astro.ucla.edu";
  chomp( $answer = `$command` );
  @answer = split /\s+/, $answer;
  print "file size = ".$fileSize."     ";
  print "archive size = ".$answer[3];
  $diff = $fileSize - $answer[3];
  print "        diff = ".$diff."\n";
  #print $answer."\n";
  # If file sizes don't match, download the file.
  if ( abs($diff) >= 1 ) {
    $command="bbftp -w 50065 -V -S -u bbftp -p 12  -e \"get ".$Sarchivefiles[$i].
    " ".$tdrawfiles[$i]."\" gamma1.astro.ucla.edu";
    print $command."\n";
    system $command;
    $command="time -p /usr/local/bin/bbcp $tdrawfiles[$i] $drawfiles[$i]";
    print "\t".$command."\n";
    system $command;
    $command="rm $tdrawfiles[$i]";
    print "\t".$command."\n";
    system $command;
    $command="chown ".$ENV{'USER'}.":veritas ".$drawfiles[$i];
    print $command."\n";
    system( $command );
    $command="chmod ug+rw ".$drawfiles[$i];
    print $command."\n";
    system( $command );
    $lncommand="ln -f -s $drawfiles[$i] /a/data/$servers[$si]/$ENV{'USER'}/${sourcename}/${version}/${drun}s2.root";
    print $lncommand."\n";
    system $lncommand;
    $lncommand="ln -f -s $drawfiles[$i] /a/data/tehanu/$ENV{'USER'}/${sourcename}/${version}/${drun}s2.root";
    print $lncommand."\n";
    system $lncommand;
  } 
  else 
  {
    print "Got it already!\n";
  }
  # Change file ownership and permissions
      
  #    # Add file to list of running flasher jobs (when will I remove it?)
  #    if ( ! open NOWRUNNING, ">>", $alreadyRunFlashers ) 
  #    {
  #	die "Cannot open run list: $!";
  #    }
  #    print NOWRUNNING $fruns[$i]."\n";
  #    close NOWRUNNING;

  # Build the analysis script and submit the job
  chdir $douts[$si];
  $runparamscript = $douts[$si]."/".$paramscript."_".$drun;
  copy($scriptdir."/".$paramscript, $runparamscript) or
    die "Cannot copy ".$scriptdir."/".$paramscript." to ".$runparamscript;
  if ( ! open SCRIPT, ">>", $runparamscript )
  {
    die "Cannot open $runparamscript: $!";
  }
  #print SCRIPT "Requirements = machine == \"$servers[$si].nevis.columbia.edu\"\n";
  print SCRIPT "output = $douts[$si]/Para_$drun.out\n";
  print SCRIPT "error  = $douts[$si]/Para_$drun.err\n";
  print SCRIPT "log    = $douts[$si]/Para_$drun.log\n";
  print SCRIPT "Notification = Error\n";
  print SCRIPT "initialdir = $douts[$si]\n";
  print SCRIPT "RunNumber = $drun\n";
  print SCRIPT "OutDir = $douts[$si]\n";
  print SCRIPT "RawFile = $drawfiles[$i]\n";
  #print SCRIPT "Flasher = $fruns[$i]\n";
  print SCRIPT "Flasher = NULL \n";
  print SCRIPT "RawDir = $draws[$si]\n";
  print SCRIPT "Server = $servers[$si]\n";
  print SCRIPT "LT = $auto_lt[$i]\n";
  print SCRIPT "LnDir = $lndir\n";
  print SCRIPT "StCode = $stagecode\n";
  print SCRIPT "Version = $version\n";
  print SCRIPT "DispTable = $auto_dt[$i]\n";
  print SCRIPT "User = ".$ENV{'USER'}."\n";
  print SCRIPT "queue 1\n";
  close SCRIPT;
  #system "condor_submit $runparamscript\n";
  #print "sleeping \n";
  #sleep (3);
  print "\n\n";
}
