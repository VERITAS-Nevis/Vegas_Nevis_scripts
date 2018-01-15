#!/usr/bin/perl
use File::Copy;
use File::Path qw(make_path remove_tree);

# Last update: added auto-creation of some source dirs, probably not all!!

$runlist = $ARGV[0];     # Run list to analyze
$listtype = $ARGV[1];    # Controls if run list holds single column of data
                         # runs (0) or two columns: data run / flasher run (1)
$version = $ARGV[2];     # vegas version to use, assumes prefix "vegas-"
$sourcename = $ARGV[3];  # Name of the source we're analyzing
#$options = $ARGV[3];     # Name of file listing key options for analysis
$offsets = $ARGV[4];     # LT offsets available: "050" or "all"
$stagecode = $ARGV[5];   # Stages to run the analysis on
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

$dbhost = $ENV{'VDBHOST'};

# Set up paths to key directories and files on tehanu.
$scriptdir = "/a/home/tehanu/".$ENV{'USER'}."/Analysis/scripts";
$calibscript = "goCal.cmd";
$paramscript = "goPar.cmd";
$rawtmpdir = "/a/data/tehanu/RawTmp";
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
    make_path($tehanuFlashers) or die "Cannot create directory $tehanuFlashers: \'$!\'";
}

# Set up the paths on the analysis/storage servers.
@servers = ( "ged", "serret", "vetch" );
$nServ = 3;
for $server (@servers) {
    $raw1 = "/a/data/".$server."/Raw/Flasher";
    unless ( -d $raw1 ) {
	make_path($raw1) or die "Cannot create directory $raw1";
    }
    @fraws = ( @fraws, $raw1 );
    $out1 = "/a/data/".$server."/".$ENV{'USER'}."/Flasher/".$version;
    unless ( -d $out1 ) {
	make_path($out1) or die "Cannot create directory $out1: \'$!\'";
    }
    unless ( -d "$out1/Log" ) {
	make_path("$out1/Log") or die "Cannot create directory $out1/Log: \'$!\'";
    }
    @fouts = ( @fouts, $out1 );
    $raw1 = "/a/data/".$server."/Raw/".$sourcename;
    unless ( -d $raw1 ) {
	make_path($raw1) or die "Cannot create directory $raw1";
    }
    @draws = ( @draws, $raw1 );
    $out1 = "/a/data/".$server."/".$ENV{'USER'}."/".$sourcename;
    unless ( -d $out1 ) {
	make_path($out1) or die "Cannot create directory $out1";
    }
    $out1 = "/a/data/".$server."/".$ENV{'USER'}."/".$sourcename."/".$version;
    unless ( -d $out1 ) {
	make_path($out1) or die "Cannot create directory $out1";
    }
    unless ( -d "$out1/Log" ) {
	make_path("$out1/Log") or die "Cannot create directory $out1/Log";
    }
    @douts = ( @douts, $out1 );
}

# Make sure critical directories exist.
$out1 = "/data/".$ENV{'USER'}."/".$sourcename;
unless ( -d $out1 ) {
    make_path($out1) or die "Cannot create directory $out1";
}
unless ( -d $lndir ) {
    make_path($lndir) or die "Cannot create directory $lndir";
}
unless ( -d "$lndir/Log" ) {
    make_path("$lndir/Log") or die "Cannot create directory $lndir/Log";
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
if ( ! open LIST, "<", $runlist ) 
{
    die "Cannot open run list: $!";
}
$naptime=2;
$iii=0;
while (<LIST>)
{
## In loop for each run: for a given list type (if statement for each) , get the groupid and flasherRun numbers with the mysql commands
    if ( $listtype == 0 ) {
	$dataRun = $_;
	sleep $naptime;
	$groupid=`mysql -h $dbhost -u readonly -D VERITAS --execute="select t1.group_id from tblRun_Group as t1, tblRun_GroupComment as t2 where t1.run_id=$dataRun and t1.group_id=t2.group_id and t2.group_type='laser'" | xargs echo -n  | cut -d " " -f 2`;
	chomp( $groupid );
	sleep $naptime;
	$flasherRun=`mysql -h $dbhost -u readonly -D VERITAS --execute="select t2.run_id from tblRun_Group as t1, tblRun_Info as t2 where t1.group_id=$groupid and t1.run_id=t2.run_id and (t2.run_type='flasher' or t2.run_type='laser')" | xargs echo -n  | cut -d " " -f 2`;
    }
    elsif ( $listtype == 1 ) {
	@line = split /\s+/, $_;
	$dataRun = $line[0];
	$flasherRun = $line[1];
    }
    else {
	print "Don't recognize listtype of ".$listtype." -- should be 0 or 1.\n";
    }
    chomp($dataRun);
    chomp( $flasherRun );
    @druns = ( @druns, $dataRun );
    @fruns = ( @fruns, $flasherRun );
#Organize run directories within proper server    
    $serverIndex = $iii % $nServ;
    $drawfile=$draws[$serverIndex]."/".$dataRun.".cvbf";
    @drawfiles = ( @drawfiles, $drawfile );
    $tdrawfile=$rawtmpdir."/".$dataRun.".cvbf";
    @tdrawfiles = ( @tdrawfiles, $tdrawfile );

# Get dates for run and Flashers
    sleep $naptime;
    $dDate=`mysql -h $dbhost -u readonly -D VERITAS --execute=\"select db_start_time from tblRun_Info where run_id=$dataRun\" | xargs echo -n  | cut -d " " -f 2`;
    chomp( $dDate );
    $dataDate = substr($dDate,0,4).substr($dDate,5,2).substr($dDate,8,2);
    $dataYear = substr($dDate,0,4);
    $dataMonth = substr($dDate,5,2);
    $dataDay = substr($dDate,8,2);
    sleep $naptime;
    $fDate=`mysql -h $dbhost -u readonly -D VERITAS --execute=\"select db_start_time from tblRun_Info where run_id=$flasherRun\" | xargs echo -n  | cut -d " " -f 2`;
    chomp( $fDate );
    $flasherDate = substr($fDate,0,4).substr($fDate,5,2).substr($fDate,8,2);

# Organize paths to flasher and raw files/temps to directories, with the right filename
    $trawfile=$rawtmpdir."/".$flasherRun.".cvbf";
    @trawfiles = ( @trawfiles, $trawfile );

    $frawfile=$fraws[$serverIndex]."/".$flasherRun.".cvbf";
    @frawfiles = ( @frawfiles, $frawfile );

    $foutfile=$fouts[$serverIndex]."/".$flasherRun.".root";
    @foutfiles = ( @foutfiles, $foutfile );

    $farchivefile="/veritas/data/d".$flasherDate."/".$flasherRun.".cvbf";
    @farchivefiles = ( @farchivefiles, $farchivefile );

    $darchivefile="/veritas/data/d".$dataDate."/".$dataRun.".cvbf";
    @darchivefiles = ( @darchivefiles, $darchivefile );

# Use run date from above to set the epoch and atm for this run (not filling an array, instead used to set the lookup tables)
    $atm = "20";
    $epoch = "xx";
    $offs = "none";
    if ( $dataMonth <= 4 || $dataMonth >= 11 ) { # winter
	$atm = "21";
    }
    else { # summer
	$atm = "22";
    }
    if ( $dataDate > 20120801 ) { # V6: upgraded array
	$epoch = "ua";
    }
    elsif ( $dataDate > 20090801 ) { # V5: new array
	$epoch = "na";
    }
    else{ # V4: old array
	$epoch = "oa";
    }
    if ( $offsets eq '050' ) { # Choice of offset - only applies to LT
	$offs = "050wobb";      # at present !!!
    }
    elsif ( $offsets eq 'all' ) {
	$offs = "allOffsets";

# Extra bits need for some tables, based on date
	if ( $dataDate > 20120801 ) { # fix for some V6 tables
	    $extrabit = "_noise150fix";
	}
        elsif ( $dataDate > 20090801 && $atm eq '21') { # fix for V5 tables
            $extrabit = "_v1";
        }
    }
# Set lookup tables, first checking what kind of analysis specific in command
 
    if ( (substr($stagecode,1,1) eq '2') || ( substr($stagecode,1,1) eq '4') ) { # HFit lookup tables
	#$alt = "/a/data/tehanu/ap3115/LTs/vegas-2.5/lt_Oct2012_".$epoch."_ATM".$atm."_7samples_hfit_vegasv251_050wobb_LZA.root";
	$alt = "/a/data/tehanu/dribeiro/LTs/vegas-2.5/lt_Oct2012_".$epoch."_ATM".$atm."_7samples_hfit_vegasv251_050wobb_LZA.root";
    }
    else { # regular lookup tables
	#$alt = "/a/data/tehanu/ap3115/LTs/vegas-2.5/lt_Oct2012_".$epoch."_ATM".$atm."_7samples_vegasv250rc5_".$offs."_LZA".$extrabit.".root";
	$alt = "/a/data/tehanu/dribeiro/LTs/vegas-2.5/lt_Oct2012_".$epoch."_ATM".$atm."_7samples_vegasv250rc5_".$offs."_LZA".$extrabit.".root";
#	$alt = "/a/data/tehanu/ap3115/LTs/vegas-2.5/lt_Oct2012_ua_ATM21_7samples_vegasv250rc5_050wobb_LZA.root";
#	$adt = "/a/data/tehanu/ap3115/DTs/vegas-2.5/rc4/dt_Oct2012_ua_ATM21_7samples_vegasv250rc4_050wobb_LZA.root";
#	$alt = "/a/data/tehanu/ap3115/LTs/vegas-2.5/lt_Oct2012_ua_ATM22_7samples_vegasv250rc5_050wobb_LZA.root";
#	$adt = "/a/data/tehanu/ap3115/DTs/vegas-2.5/rc4/dt_Oct2012_ua_ATM22_7samples_vegasv250rc4_050wobb_LZA.root";
    }
       
        if ( substr($stagecode,2,1) eq '1') { #geo - no table necessary
          $adt = "-"; 
          }
        elsif ( substr($stagecode,2,1) eq '2'){ #disp old - old table
          #$adt = "/a/data/tehanu/humensky/DTs/vegas-2.5/dt_Oct2012_".$epoch."_ATM".$atm."_7samples_vegasv250rc5_050wobb_LZA.root"; 
          $adt = "/a/data/tehanu/dribeiro/DTs/vegas-2.5/dt_Oct2012_".$epoch."_ATM".$atm."_7samples_vegasv250rc5_050wobb_LZA.root"; 
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
}
$ntot = $iii; # total number of runs in list.
print "Dealing with ".$iii." runs\n";

###############################################################################
###############################################################################
# Loop over flasher runs, checking whether they are already available or need to be downloaded
# or processed. As needed, download and/or process them.
###############################################################################
###############################################################################

for ( $i=0; $i<$ntot; $i++ ) {
    $si = $i % $nServ; # server index - brief name
    $frun = $fruns[$i];
    print "Flasher ".$frun."\n";
    # First check if the file has been processed and copied to tehanu already:
    $tehanuPath = $tehanuFlashers."/".$frun.".root";
    if ( -e $tehanuPath  ) {
	print "\tFlasher run ".$frun." already processed and on tehanu - skipping...\n";
	next;
    } else {
	print "\tNot on tehanu! Run already? Do we need to get and/or analyze it?\n";
    }
    # If not, check if we're currently analyzing this file
#    if ( ! open NOWRUNNING, "<", $alreadyRunFlashers ) {
#	die "Cannot open $alreadyRunFlashers: $!";
#    }
#    $isRunning = 0;
#    while (<NOWRUNNING>) {
#	$af = $_;
#	chomp $af;
#	if ( $frun == $af ) {
#	    $isRunning = 1;
#	    print $frun." already run.\n";
#	    last;
#	}
#    }
#    close NOWRUNNING;
    $condorInfo = `condor_q | grep goCal.sh | awk '\$2==\"$ENV{'USER'}\"{print \$10}'`;
    $isRunning = 0;
    foreach $aRun (split(' ', $condorInfo))
    {
	if ( $frun == $aRun ) {
	    $isRunning = 1;
	    print "\t\t".$frun." already running.\n";
	    last;
	}
    }
    next if ($isRunning == 1);
    # Lastly, check if it's already downloaded at least!
    $foundCVBF = 0;
    $possible = -1;
    for ( $serverIndex=0; $serverIndex<3; $serverIndex++ ) {
	$check = $fraws[$serverIndex]."/".$frun.".cvbf";
	#print "Checking for ".$check."\n";
	if ( -e $check ) {
	    $foundCVBF = 1;
	    $command="ls -l ".$check;
	    #print $command."\n";
	    chomp( $fileInfo = `$command` );
	    @fileInfo = split /\s+/, $fileInfo;
	    $fileSize = $fileInfo[4];
	    $possible = $serverIndex;
	    last;
	} else {
	    $fileSize = 0;
	}
    }
    print "\tLocal size = ".$fileSize.": ".$fraws[$possible]."\n";
    # Check remote file size
    $command="bbftp -w 50065 -m -p 1 -u bbftp -V -S -e \"stat ".$farchivefiles[$i].
	"\" gamma1.astro.ucla.edu";
    chomp( $answer = `$command` );
    @answer = split /\s+/, $answer;
    print "\tArchive size = ".$answer[3];
    $diff = $fileSize - $answer[3];
    print "        diff = ".$diff."\n";
    # If file sizes don't match, download the file.
    if ( abs($diff) >= 1 ) {
	$command="bbftp -w 50065 -V -S -u bbftp -p 6  -e \"get ".$farchivefiles[$i].
	    " ".$trawfiles[$i]."\" gamma1.astro.ucla.edu";
	print "\t".$command."\n";
	system $command;
	$command="time -p /usr/local/bin/bbcp $trawfiles[$i] $frawfiles[$i]";
	print "\t".$command."\n";
	system $command;
	$command="rm $trawfiles[$i]";
	print "\t".$command."\n";
	system $command;
	$command="chown ".$ENV{'USER'}.":veritas ".$frawfiles[$i];
	system( $command );
	$command="chmod ug+rw ".$frawfiles[$i];
	system( $command );
    } else {
	print "\tGot it already!\n";
	$si = $possible; #update host server for this guy.
    }
    # Change file ownership and permissions
    
    # Add file to list of running flasher jobs (when will I remove it?)
    if ( ! open NOWRUNNING, ">>", $alreadyRunFlashers ) 
    {
	die "Cannot open run list: $!";
    }
    print NOWRUNNING $fruns[$i]."\n";
    close NOWRUNNING;


    # Build the analysis script and submit the job
    chdir $fouts[$si];
    $runcalibscript = $fouts[$si]."/".$calibscript."_".$frun;
    copy($scriptdir."/".$calibscript, $runcalibscript) or
	die "Cannot copy ".$scriptdir."/".$calibscript." to ".$runcalibscript;
    if ( ! open SCRIPT, ">>", $runcalibscript )
    {
	die "Cannot open $runcalibscript: $!";
    }
    print SCRIPT "Requirements = Memory > 1900 && machine == \"$servers[$si].nevis.columbia.edu\"\n";
    print SCRIPT "output = Cali_${frun}.out\n";
    print SCRIPT "error  = Cali_${frun}.err\n";
    print SCRIPT "log    = Cali_${frun}.log\n";
    print SCRIPT "initialdir = $fouts[$si]\n";
#    print SCRIPT "output = $fouts[$si]/Cali_${frun}.out\n";
#    print SCRIPT "error  = $fouts[$si]/Cali_${frun}.err\n";
#    print SCRIPT "log    = $fouts[$si]/Cali_${frun}.log\n";
#    print SCRIPT "initialdir = $fouts[$si]\n";
#    print SCRIPT "RawDir = $raws[$si]\n";
  #  print SCRIPT "DataDir = $outs[$si]\n";
    print SCRIPT "RunNumber = ".$fruns[$i]."\n";
    print SCRIPT "Server = $servers[$si]\n";
    print SCRIPT "Version = $version\n";
    print SCRIPT "User = ".$ENV{'USER'}."\n";
    print SCRIPT "queue 1\n";
    close SCRIPT;
    system "condor_submit $runcalibscript\n";
    print "\n\n";
}

#exit 0;

###############################################################################
###############################################################################
# Download data runs and submit their analysis jobs.
# Loop over data runs, checking whether they are already available or need to be downloaded.
# If needed, download them. Then process them. 
###############################################################################
###############################################################################

for ( $i=0; $i<$ntot; $i++ ) {
    $si = $i % $nServ; # server index - brief name
    $drun = $druns[$i];
    print "\n\nData ".$drun."\n";
    # Check if it's already downloaded.
    $foundCVBF = 0;
    for ( $serverIndex=0; $serverIndex<3; $serverIndex++ ) {
	$check = $draws[$serverIndex]."/".$drun.".cvbf";
	print "Checking for ".$check."\n";
	if ( -e $check ) {
	    $foundCVBF = 1;
	    $command="ls -l ".$check;
	    print $command."\n";
	    chomp( $fileInfo = `$command` );
	    @fileInfo = split /\s+/, $fileInfo;
	    $fileSize = $fileInfo[4];
	    $si = $serverIndex;
	    $drawfiles[$i] = $check;
	    last;
	} else {
	    $fileSize = 0;
	}
	print "  local size = ".$fileSize."\n";
    }
    # Check remote file size
    $command="bbftp -w 50065 -m -p 1 -u bbftp -V -S -e \"stat ".$darchivefiles[$i].
	"\" gamma1.astro.ucla.edu";
    chomp( $answer = `$command` );
    @answer = split /\s+/, $answer;
    print "archive size = ".$answer[3];
    $diff = $fileSize - $answer[3];
    print "        diff = ".$diff."\n";
    #print $answer."\n";
    # If file sizes don't match, download the file.
    if ( abs($diff) >= 1 ) {
	$command="bbftp -w 50065 -V -S -u bbftp -p 12  -e \"get ".$darchivefiles[$i].
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
    } else {
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
    $runparamscript = $douts[$si]."/".$paramscript."_".$stagecode."_".$drun;
    copy($scriptdir."/".$paramscript, $runparamscript) or
  	  die "Cannot copy ".$scriptdir."/".$paramscript." to ".$runparamscript;
    if ( ! open SCRIPT, ">>", $runparamscript )
    {
    	die "Cannot open $runparamscript: $!";
    }
    #print SCRIPT "Requirements = Memory > 1000 && machine == \"$servers[$si].nevis.columbia.edu\"\n";
    print SCRIPT "output = $douts[$si]/Para_$stagecode._$drun.out\n";
    print SCRIPT "error  = $douts[$si]/Para_$stagecode._$drun.err\n";
    print SCRIPT "log    = $douts[$si]/Para_$stagecode._$drun.log\n";
    print SCRIPT "Notification = Error\n";
    print SCRIPT "initialdir = $douts[$si]\n";
    print SCRIPT "RunNumber = $drun\n";
    print SCRIPT "OutDir = $douts[$si]\n";
    print SCRIPT "RawFile = $drawfiles[$i]\n";
    print SCRIPT "Flasher = $fruns[$i]\n";
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
    system "condor_submit $runparamscript\n";
}




