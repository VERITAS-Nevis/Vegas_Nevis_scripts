#!/usr/bin/perl

#runlist=$1
$sourcename=$ARGV[0];
$suffix=$ARGV[1];

#@epochs=("oa", "na", "ua");
@epochs=("ua");
#@wobbles=("000", "025", "050", "075", "100", "125", "150", "175", "200");
@wobbles=("000", "025", "050", "075", "100", "125", "150", "175", "200");
#@atms=("21", "22");
@atms=("21");
#@Zeniths=("00", "20", "30", "35", "40", "45", "50", "55", "60", "65");
@Zeniths=("45", "50", "55", "60", "65");
#@noises=("100", "150", "200", "250", "300", "350", "400", "490", "605", "730", "870");
@noises=("350", "400");

#bin_range="_0_3_"
$bin_range="";

#Effective Areas:

#V5 geo Winter Med
#EA=/a/data/tehanu/ap3115/EAs/vegas-2.5/ea_Oct2012_na_ATM21_vegasv250rc5_7sam_Alloff_s400t2_std_MSW1p1_MSL1p3_MH7_ThetaSq0p01_v1.root;

#V6 geo Winter Med 
$EA="/a/data/tehanu/ap3115/EAs/vegas-2.5/ea_Oct2012_ua_ATM21_vegasv250rc5_7sam_Alloff_s700t2_std_MSW1p1_MSL1p3_MH7_ThetaSq0p01_LZA_fixed150.root";

#V5 disp-new Winter Med
#V6 disp-new Winter Med
#V5 disp-old Winter Med
#V6 disp-old Winter Med

$dir="/a/data/tehanu/dribeiro/${sourcename}/2_5_4/";
$runlistdir="/a/home/tehanu/dribeiro/Analysis/${sourcename}/runlists/stage6/PerRun";

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
          $dataRun="Oct2012_".$epoch."_ATM".$atm."_vegasv250rc5_7samples_".$zenith."deg_".$wobble."wobb_".$noise."noise";
          $runparamscript="${runlistdir}/$dataRun-${cuts}-${suffix}${bin_range}.txt";
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
          print SCRIPT $dataRun."s5-".${cuts}."-".${suffix}.".root\n";
          print SCRIPT "[EA ID: 0]\n"; 
          print SCRIPT "${EA}\n";
          print SCRIPT "[/EA ID: 0]\n";
          print SCRIPT "[CONFIG ID: 0]\n"; 
          print SCRIPT "S6A_RingSize 0.4\n"; 
          print SCRIPT "RBM_SearchWindowSqCut 0.16\n" ;
          print SCRIPT "EnergyLower 0\n";
          print SCRIPT "EnergyUpper 10000\n";
          $file="/a/home/tehanu/dribeiro/Analysis/Cuts/st5${cuts}.cut";
          #print ${file};
          {
            local $/=undef;
            open FILE, ${file} or die "Couldn't open file: $!";
            $string = <FILE>;
            close FILE;
            }
          print SCRIPT $string."\n";
          print SCRIPT "[/CONFIG ID: 0]\n";
        }
      }
    }
  }
}


