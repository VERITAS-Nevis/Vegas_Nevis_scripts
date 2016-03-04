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
char suffix[10] = "disp_new";

cout << "LoadMacro"<<endl;
int error = 0;
//gROOT->ProcessLine(".L /a/home/tehanu/omw2107/classes/vegasAnalysis.cpp");
//gROOT->LoadClass("/a/home/tehanu/omw2107/classes/vegasAnalysis.cpp");
gSystem->Load("/a/home/tehanu/omw2107/vegas-2.5.0rc5/macros/rootLib_C.so");
gROOT->LoadMacro("/a/home/tehanu/omw2107/classes/vegasAnalysis.cpp");
gROOT->LoadMacro("/a/home/tehanu/omw2107/scripts/computeTrueDisp.cpp");
gROOT->LoadMacro("/a/home/tehanu/omw2107/scripts/generateRandomIndices.cpp");
gROOT->LoadMacro("$ROOTSYS/tmva/test/TMVARegGui.C");
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
  char Error_table[100];
  sprintf(Error_table,"%sErrors_%s.txt",runlistdir,suffix);
  FILE * efile = fopen(Error_table,"w");
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

      char dataRun[200];
      char runlist_file[200];
      sprintf( dataRun, "Oct2012_%s_ATM%i_vegasv250rc5_7samples_%02ideg_%03iwobb_%03inoise",epo, atms,Zeniths[zenith_i], wobbles[wobble_i], noises[noise_i]);
      sprintf(runlist_file, "%s%s-%s-%s.txt",runlistdir,dataRun,cuts,suffix);

      vector <float> bin;
      vector <float> res;
      vector <float> rms;
      fprintf(stdout,"\nSetting up the create_dataAnalysis_object()\n");
      fprintf(stdout,"%s\n",runlist_file);
      //sprintf(runlist_file,"/a/home/tehanu/omw2107/results/test.txt");


///////
//Check that text file is good, and print out contents to make sure
///////
      bool good = 0;
      ifstream runlist_file_binary(runlist_file);
      if (runlist_file_binary.is_open())
      {
        fprintf(stdout,"\n###############################\n");
        fprintf(stdout,"Printing out text of file: \n");
        fprintf(stdout,"###############################\n");
        while (getline(runlist_file_binary, line))
        {
          cout << line << endl;
        }
        fprintf(stdout,"###############################\n");
        fprintf(stdout,"###############################\n");
        string buffer[200];
	//open text file
	string line1;
  char * pathToTextFile = runlist_file;
	ifstream textFile(pathToTextFile);
  bool isSimulationAnalysis;

	//get first line to determine if sim or data
	getline(textFile, line1);

	if(!strcmp(line1.c_str(), "sim"))
		{isSimulationAnalysis = 1;
    cout << "...sim" << endl;}
	else if(!strcmp(line1.c_str(), "data"))
		{isSimulationAnalysis = 0;
    cout << "...data" << endl;}
	else
		{cout << "Checking first: Error: you need to specify whether sim or data analysis\n";
}

	//loop over whole text file to get list of files
	bool nextLineIsStage2 = 1;
	int numOfRuns = 0;
	while(getline(textFile, line1)){

		if(!strcmp(line1.c_str(), "")) {continue;} //skip if empty line
		
		if(nextLineIsStage2){
			numOfRuns++;
			nextLineIsStage2 = 0;
		}
		else{
			nextLineIsStage2 = 1;		
		}

	}
  cout << "Num of Runs: "<< numOfRuns << endl;
///////
//Check that ST5 exist, since it may still be running or nonexistent"
///////
        sprintf(buffer.c_str(),"/a/data/tehanu/dribeiro/CrabSim/2_5_4/%ss5-%s-%s.root",dataRun,cuts,suffix);
        ifstream infile_st5(buffer.c_str());
        cout << "Checking that ST5 file is good..."<<endl;
        if(infile_st5.good())
        {
          cout << "ST5 file exists, trying to open it..."<<endl;
          TFile* f = new TFile(buffer.c_str(), "READ");
          cout << "created f"<<endl;
          good=1;
        }
        else {
          cout<< "St5 root file does not exist"<<endl;
          fprintf(efile,"%ss5-%s-%s\n",dataRun,cuts,suffix);
          good=0;
          continue;
          }
        infile_st5.close();
      }
      else
      {
        cout<< "Text file didn't open for some reason, maybe it doesn't exist."<< endl;
      }

///////
//With good text file, now try loading analysis class
///////
      if(good)
      {
        cout << "creating object... " << endl;
        fprintf(stdout, "vegasAnalysis *v = new vegasAnalysis(\"%s\",999999);\n", runlist_file);
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

      runlist_file_binary.close();
      delete v;
      runlist_file="";
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
