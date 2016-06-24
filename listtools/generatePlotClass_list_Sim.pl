#!/usr/bin/perl

#This generates a single file for each vegasAnalysis runlist - looping through sims.
# OR it make a single txt file for everything (uncomment to use that version)

#runlist=$1
$sourcename=$ARGV[0];
$suffix=$ARGV[1];

#@epochs=("oa", "na", "ua");
@epochs=("na","ua");
#@wobbles=("000", "025", "050", "075", "100", "125", "150", "175", "200");
@wobbles=("000", "025", "050", "075", "100", "125", "150", "175", "200");
#@atms=("21", "22");
@atms=("21");
#@Zeniths=("00", "20", "30", "35", "40", "45", "50", "55", "60", "65");
@Zeniths=("20","45", "50", "55", "60", "65");
#@noises=("100", "150", "200", "250", "300", "350", "400", "490", "605", "730", "870");
@noises=("350", "400");

$dir="/a/data/tehanu/dribeiro/${sourcename}/2_5_4/";
$runlistdir="/a/home/tehanu/dribeiro/Analysis/${sourcename}/runlists/Classes/";

$cuts="med-com";

chdir $runlistdir;

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
          #ex: Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_175wobb_350noises5-med-com-disp_new.root
          $dataRun="Oct2012_".$epoch."_ATM".$atm."_vegasv250rc5_7samples_".$zenith."deg_".$wobble."wobb_".$noise."noise";
          $runparamscript="${runlistdir}/$dataRun-${cuts}-${suffix}.txt";
          if ( ! open SCRIPT, ">>", $runparamscript )
          {
            $command="mkdir -p ${runlistdir}";
            system $command;
            $command="touch ${runparamscript}";
            system $command;
          }
          chomp($dataRun);
          chomp( $flasherRun );
          @druns = ( @druns, $dataRun );
          @fruns = ( @fruns, $flasherRun );
          print SCRIPT "sim\n\n";
          print SCRIPT $dir.$dataRun."s2.root\n\n";
          print SCRIPT $dir.$dataRun."s5-".${cuts}."-".${suffix}.".root";
        }
      }
    }
  }
}

#below, remove =for comment and =cut blocks to make active. This section makes a single txt file for the vegasAnalysis class. 

=for comment
$runparamscript="${runlistdir}/Runlist_${suffix}.txt";
if ( ! open SCRIPT, ">>", $runparamscript )
{ 
  $command="mkdir -p ${runlistdir}";
  system $command;
  $command="touch ${runparamscript}";
  system $command;
}
print SCRIPT "sim\n\n";

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
          #ex: Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_175wobb_350noises5-med-com-disp_new.root
          $dataRun="Oct2012_".$epoch."_ATM".$atm."_vegasv250rc5_7samples_".$zenith."deg_".$wobble."wobb_".$noise."noise";
          chomp($dataRun);
          chomp( $flasherRun );
          @druns = ( @druns, $dataRun );
          @fruns = ( @fruns, $flasherRun );
          print SCRIPT $dir.$dataRun."s2.root\n\n";
          print SCRIPT $dir.$dataRun."s5-".${cuts}."-".${suffix}.".root\n\n\n";
        }
      }
    }
  }
}
=cut
