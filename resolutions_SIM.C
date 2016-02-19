#include "TROOT.h"
#include "TSystem.h"
#include "TApplication.h"
#include <iostream>
#include <string>
#include <fstream>

using namespace std;
{
int epochs = 6;
int wobbles[9] = {0, 25, 50, 75, 100, 125, 150, 175, 200};
int atms=21;
int Zeniths[5]={45, 50, 55, 60, 65};
int noises[2]={350, 400};

char runlistdir[200] = "/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes/";
char cuts[10] = "med-com";
char suffix[10] = "geo";

cout << "loadmacro"<<endl;
int error = 0;
gROOT->ProcessLine(".L /a/home/tehanu/omw2107/classes/vegasAnalysis.cpp");
if(error!=0)
{ 
  cout <<"failed"<<endl;
  return 0;
  }
else
{ 
  cout << "vegasAnalysis.cpp loaded properly" << endl;
  }
}

void loop_thru_sims()
{
  char results_table[100];
  sprintf(results_table,"%sResults_%s.txt",runlistdir,suffix);
  FILE * file = fopen(results_table,"a+");
  string txt[300];
  string line;
  int bins = 10;
  for ( int wobble_i = 0 ; wobble_i < 9 ; wobble_i++ )
  {
    for ( int zenith_i = 0 ; zenith_i < 5 ; zenith_i++ )
    {
      for ( int noise_i = 0 ; noise_i < 2 ; noise_i++ )
      {
      char epo[3];
      if( epochs==6 ){sprintf(epo,"ua");}
      else if( epochs==5 ){sprintf(epo,"na");}

      char dataRun[200], runlist_file[200];
      sprintf( dataRun, "Oct2012_%s_ATM%i_vegasv250rc5_7samples_%02ideg_%03iwobb_%03inoise",epo, atms,Zeniths[zenith_i], wobbles[wobble_i], noises[noise_i]);
      sprintf(runlist_file, "%s%s-%s-%s.txt\n",runlistdir,dataRun,cuts,suffix);

      vector <float> bin;
      vector <float> res;
      vector <float> rms;
      fprintf(stdout,"Setting up the create_dataAnalysis_object()\n");
      fprintf(stdout,"%s\n",runlist_file);
      sprintf(runlist_file,"/a/home/tehanu/omw2107/results/test.txt");

      ifstream runlist_file_binary;
      runlist_file_binary.open(runlist_file);
      if (runlist_file_binary.is_open())
      {
        fprintf(stdout,"###############################\n");
        fprintf(stdout,"Printing out text of file: \n");
        fprintf(stdout,"###############################\n");
        while (getline(runlist_file_binary, line))
        {
          cout << line << endl;
        }
        fprintf(stdout,"###############################\n");
        fprintf(stdout,"###############################\n");
      }

      cout << "creating object... " << endl;
      vegasAnalysis *v = new vegasAnalysis(runlist_file,999999);
      if( v->isSimulationAnalysis){
      cout << "object created..." << endl;
      v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
          fprintf(stdout,"epo \t atms \t Zeniths \t wobble \t noise \t E_bin \t res \t rms");
      for(int i=0;i<bins;i++)
        {
          fprintf(stdout,"%s \t %i \t %i \t %03i \t %i \t %f \t %f \t %f \n",epo,atms,Zeniths[zenith_i], wobbles[wobble_i], noises[noise_i], bin[i],res[i], rms[i]);
          fprintf(file,"%s \t %i \t %i \t %03i \t %i \t %f \t %f \t %f \n",epo,atms,Zeniths[zenith_i], wobbles[wobble_i], noises[noise_i], bin[i],res[i], rms[i]);
          fflush (file);
        }
      }
      else
      { 
        cout << "something went wrong, moving on..." << endl;
      }

      }
    }
  }
  fclose(file);
}

void resolutions_SIM()
{
  vector <float> bin;
  vector <float> res;
  vector <float> rms;

  cout << "loadmacro"<<endl;
  int error = 0;
  gROOT->ProcessLine(".L /a/home/tehanu/omw2107/classes/vegasAnalysis.cpp");
  if(error!=0)
  {
    cout <<"failed"<<endl;
    return 0;
  }
  else
  {
    cout << "vegasAnalysis.cpp loaded properly \n" << endl;
  }

  loop_thru_sims();
}
