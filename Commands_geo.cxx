// This script creates the vegasAnalysis class for each sim file. Since it takes so long, must run with the following command to save to a txt, or else itll be lost
//    root -b -q /path/to/this/script/Command_geo.cxx 2&>1 | tee /path/to/text/file.txt
//
{
char epo='ua';
int epochs = 6;
int wobbles = 000;
int atms=21;
int Zeniths=45;
int noises=350;
char runlistdir[200] = "/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes/";
char cuts[10] = "med-com";
char suffix[10] = "geo";
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
vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_000wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_000wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_000wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

string runlist_file;
vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_000wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_000wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_000wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_000wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_000wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_000wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_000wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_025wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_025wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_025wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_025wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_025wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_025wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_025wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_025wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_025wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_025wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_050wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_050wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_050wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_050wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_050wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_050wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_050wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_050wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_050wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_050wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_075wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_075wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_075wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_075wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_075wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_075wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_075wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_075wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_075wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_075wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_100wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_100wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_100wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_100wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_100wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_100wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_100wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_100wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_125wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_125wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_125wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_125wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_125wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_125wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_125wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_125wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_125wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_125wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_150wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_150wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_150wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_150wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_150wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_150wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_150wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_150wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_150wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_150wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_175wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_175wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_175wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_175wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_175wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_175wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_175wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_175wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_175wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_175wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;
vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_200wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_45deg_200wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_200wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_50deg_200wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_200wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_55deg_200wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_200wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_60deg_200wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_200wobb_350noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;

vegasAnalysis *v = new vegasAnalysis("/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes//Oct2012_ua_ATM21_vegasv250rc5_7samples_65deg_200wobb_400noise-med-com-geo.txt",999999);
v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
cout << "DATATATA"<< endl;
for(int i=0;i<bins;i++) cout << epo << " " << atms << " " << Zeniths << " " <<  wobbles << " " <<  noises << " " <<  bin[i] << " " << res[i] << " " <<  rms[i] <<  endl;
}
