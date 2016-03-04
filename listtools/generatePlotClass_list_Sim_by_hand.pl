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
char runlistdir[200] = "/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes/";
char cuts[10] = "med-com";
char suffix[10] = "$suffix";
gROOT->ProcessLine(".L /a/home/tehanu/omw2107/classes/vegasAnalysis.cpp");
vector <float> bin;
vector <float> res;
vector <float> rms;
char results_table[100];
sprintf(results_table,"%sResults_%s.txt",runlistdir,suffix);
FILE * file = fopen(results_table,"a+");
char Error_table[100];
sprintf(Error_table,"%sErrors_%s.txt",runlistdir,suffix);
FILE * efile = fopen(Error_table,"w");
string txt[300];
string line;
int bins = 10;
string dataRun;
string runlist_file;
vegasAnalysis *v = new vegasAnalysis("$runparamscript",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;
gROOT->Reset();
});
print $str;


        }
      }
    }
  }
}
