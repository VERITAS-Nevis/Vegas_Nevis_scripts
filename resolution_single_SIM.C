#include "TROOT.h"
#include "TSystem.h"
#include "TApplication.h"
#include <iostream>
#include <string>
#include <fstream>

using namespace std;

int resolution_single_SIM(char * epo, int * atms, int * Zeniths, int* wobbles, int * noises, char * suffix)
{
char runlistdir[200] = "/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/Classes/";
//char suffix[10] = "disp_old";

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

  char results_table[100];
  sprintf(results_table,"%sResults_%s.txt",runlistdir,suffix);
  FILE * file = fopen(results_table,"a+");
  char Error_table[100];
  sprintf(Error_table,"%sErrors_%s.txt",runlistdir,suffix);
  FILE * efile = fopen(Error_table,"w");
  string txt[300];
  string line;
  int bins = 10;

  char dataRun[200];
  string runlist_file;
  sprintf( dataRun, "Oct2012_%s_ATM%i_vegasv250rc5_7samples_%02ideg_%03iwobb_%03inoise",epo, atms,Zeniths, wobbles, noises);
  sprintf(runlist_file.c_str(), "%s%s-%s-%s.txt",runlistdir,dataRun,cuts,suffix);

  vector <float> bin;
  vector <float> res;
  vector <float> rms;
  fprintf(stdout,"\nSetting up the create_dataAnalysis_object()\n");
  fprintf(stdout,"%s\n",runlist_file.c_str());

///////
//Check that text file is good, and print out contents to make sure
///////
      bool good = 1;
      ifstream runlist_file_binary(runlist_file.c_str());
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
  char * pathToTextFile = runlist_file.c_str();
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
//With good text file, now try loading analysis class
///////
      if(good)
      {
        cout << "creating object... " << endl;
        vegasAnalysis *v = new vegasAnalysis(runlist_file.c_str(),999999);
        if( v->isSimulationAnalysis){
          cout << "object created..." << endl;
          v->getBinnedResolution(bin, res, rms, "fEnergy_GeV", 0, bins,"Logarithmic");
          fprintf(stdout,"epo \t atms \t Zeniths \t wobble \t noise \t E_bin \t res \t rms");
          for(int i=0;i<bins;i++)
          {
            fprintf(stdout,"%s \t %i \t %i \t %03i \t %i \t %f \t %f \t %f \n",epo,atms,Zeniths, wobbles, noises, bin[i],res[i], rms[i]);
            fprintf(file,"%s \t %i \t %i \t %03i \t %i \t %f \t %f \t %f \n",epo,atms,Zeniths, wobbles, noises,bin[i],res[i], rms[i]);
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
  }
  fclose(file);
  return 0;
  }
