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

$dir="/a/data/tehanu/dribeiro/${sourcename}/2_5_4/";
$runlistdir="/a/home/tehanu/dribeiro/Analysis/${sourcename}/runlists/Classes/";

$cuts="med-com";

chdir $runlistdir;

($strlead = qq{
gROOT->ProcessLine(".L /a/home/tehanu/omw2107/classes/vegasAnalysis.cpp");
vector <float> bin;
vector <float> res;
vector <float> rms;
int bins = 10;
});
print $strlead;

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
          chomp($dataRun);
          chomp( $flasherRun );
          @druns = ( @druns, $dataRun );
          @fruns = ( @fruns, $flasherRun );
($str = qq{
char epo='$epoch';
int epochs = 6;
int wobbles = $wobble;
int atms=$atm;
int Zeniths=$zenith;
int noises=$noise;
vegasAnalysis *v = new vegasAnalysis("$runparamscript",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;
});
print $str;


        }
      }
    }
  }
}
