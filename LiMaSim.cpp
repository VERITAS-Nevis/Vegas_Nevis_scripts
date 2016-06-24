TH1D* LiMaSim(double BgRate,double ExpTime,double alpha = 0.1,double alphaRMS = 3.5e-4,double alphaDiff = 0.0,const int nTimes = 1e5)
{
  gROOT->ProcessLine(".L lima.C");
  TRandom3* rand = new TRandom(0);
  TH1D* hLiMa5 = new TH1D("hLiMa5","Li and Ma Eq. 5",200,-10,10);
  TH1D* hLiMa9 = new TH1D("hLiMa9","Li and Ma Eq. 9",200,-10,10);
  TH1D* hLiMa17 = new TH1D("hLiMa17","Li and Ma Eq. 17",200,-10,10);
  int Non,Noff;
  double alphaRand;
  for(int i=0; i<nTimes; i++)
    {
     
      Non = rand->Poisson(BgRate*ExpTime);
      //      Noff = rand->Poisson(BgRate*ExpTime/alpha);
      // ok, let's also make alpha a random variable. 
      do
	{
	  alphaRand = rand->Gaus(alpha+alphaDiff,alphaRMS); // from Segue sky map
	}
      while(alphaRand < 0.01);
      Noff = rand->Poisson(BgRate*ExpTime/alpha);
      hLiMa5->Fill(LiMa5(Non,Noff,alphaRand));
      hLiMa9->Fill(LiMa9(Non,Noff,alphaRand));
      hLiMa17->Fill(lima(Non,Noff,alphaRand));
		   
    }
  /*
  hLiMa5->SetLineColor(kGreen);
  hLiMa9->SetLineColor(kRed);
  TCanvas* c1 = new TCanvas();
  hLiMa17->Draw();
  hLiMa5->Draw("same");
  hLiMa9->Draw("same");
  hLiMa5->Fit("gaus");
  hLiMa9->Fit("gaus");
  */
  // hLiMa17->Fit("gaus");
  return(hLiMa17);
}

void plotCumulativeLiMaSim(double BgRate = 4.0,double alphaRMS = 1e-3,double alphaDiff = 0.0,double alphaMean = 0.1,double tMax = 100,double tStep = 1,const int numSim = 1e4)
{
  gROOT->ProcessLine(".L lima.C");
  TRandom3* rand = new TRandom3(0);
  // double t = 0;
  double sig,ex;
  double Non[numSim];
  double Noff[numSim];
  double alpha[numSim];
  const int numTSteps = tMax/tStep;
  TH1D* hSig[numTSteps];
  TGraph* sigWidthVTime = new TGraph();
  TF1* fFit = new TF1();
  TF1* fwidthFit = new TF1("fwidthFit","1 + [0]*pow(x,[1])",0,tMax);
  double alphaCorr;
  fwidthFit->SetParameter(1,1.0);
  for(int i=0; i<numSim; i++)
    {
      alpha[i] = rand->Gaus(alphaMean+alphaDiff,alphaRMS);
      Non[i] = 0.0;
      Noff[i] = 0.0;
    }
  for(int t=1; t<=numTSteps; t++)
    {
      cout << "time step: " << t << " of: " << numTSteps << endl;
      hSig[t] = new TH1D("hSig","Significance Dist",200,-10,10);
      for(int i=0; i<numSim; i++)
	{
	  Non[i]  += rand->PoissonD(tStep*60.0*BgRate);
	  Noff[i] += rand->PoissonD(tStep*60.0*BgRate/alphaMean);
	  // BJZ correction factor:
	  ex = Non[i] - alpha[i]*Noff;
	  if(ex > 0.0)
	    alphaCorr = alpha[i] + alphaRMS/alpha[i];
	  if(ex < 0.0)
	    alphaCorr = alpha[i] - alphaRMS/alpha[i];
	  if(ex == 0.0)
	    alphaCorr = alpha[i];
	  sig = lima(Non[i],Noff[i],alphaCorr);
	  hSig[t]->Fill(sig);
	}
      hSig[t]->Fit("gaus","0");
      fFit = hSig[t]->GetFunction("gaus");
      sigWidthVTime->SetPoint(t-1,t*tStep,fFit->GetParameter(2));
    } 
  sigWidthVTime->Draw("A*");
  sigWidthVTime->Fit(fwidthFit);
}

void plotMultiLiMaSim(double BgRate = 4.0,double alphaRMS = 1e-3)
{
  const int num = 3;
  double t[] = {1000,3000,6000};
  TH1D* h[num];
  ostringstream os[num];
  TCanvas* c1 = new TCanvas();
  TLegend* leg = new TLegend(0.6,0.6,0.9,0.9);
  for(int i=0; i<num; i++)
    {
      h[i]=(TH1D*)LiMaSim(BgRate,t[i],0.1,alphaRMS)->Clone();
      h[i]->SetLineColor(i+1);
      os[i] << "Exposure time: " << t[i]/60.0 << " hrs";
      leg->AddEntry(h[i],os[i].str().c_str(),"L");
      if(i==0){ h[i]->Draw(); }
      else{ h[i]->Draw("same"); }
    }
  leg->Draw("same");
}

TH2D* plot2DWidthSmallNum(double NonMax = 25,double alphaMax = 0.3,double NonNumBins= 30,double alphaNumBins = 30)
{
  alphaMin = alphaMax/alphaNumBins;
  TH2D* h2DWidth = new TH2D("h2DWidth","",alphaNumBins,alphaMin,alphaMax,NonNumBins,1,NonMax);
  double onRate,alpha;
  TH1D* hBin = new TH1D();
  TF1* fFit = new TF1();
  for(int i=1; i<=NonNumBins; i++)
    for(int j=1; j<=alphaNumBins; j++)
      {
	onRate = (double)i;
	alpha = j*alphaMax/alphaNumBins;
	cout << onRate << " " << alpha << endl;
	hBin = LiMaSim(onRate,1.0,alpha,0.008);
	hBin->Fit("gaus","0");
	fFit = hBin->GetFunction("gaus");
	h2DWidth->SetBinContent(j,i,fFit->GetParameter(2));
      }
  h2DWidth->Draw("colz");

}

TGraph* plotLongTermWidth(double BgRate,double alphaRMS,double alpha = 0.1,double tMax = 100,double dt = 1)
{

  TGraph* g = new TGraph();
  TGraph* g0 = new TGraph();
  TH1D* h = new TH1D();
  TF1* fGausFit = new TF1();
  //TF1* fSqrtTimeFit = new TF1("fSqrtTimeFit","[0]*sqrt(x) + 1.0",1.0,tMax);
  //TF1* fLinearTimeFit = new TF1("fSqrtTimeFit","[0]*x + 1.0",1.0,tMax);
  TF1* fPLTimeFit = new TF1("fSqrtTimeFit","[0]*pow(x,[1]) + 1.0",1.0,tMax);
  fPLTimeFit->SetParLimits(1,0.0,1.0);
  int ptNum = 0;
  for(int nHours = 1; nHours < tMax; nHours+=dt)
    {
      cout << "On step: " << nHours << endl;
      h = (TH1D*)LiMaSim(BgRate,nHours*60.0,0.1,alphaRMS);
      h->Fit("gaus","0");
      fGausFit = h->GetFunction("gaus");
      g->SetPoint(ptNum,nHours,fGausFit->GetParameter(2));
      /*
      h = (TH1D*)LiMaSim(BgRate,nHours*60.0,0.1,0.0);
      h->Fit("gaus","0");
      fGausFit = h->GetFunction("gaus");
      g0->SetPoint(ptNum,nHours,fGausFit->GetParameter(2));
      */
      ptNum++;
    } 
  return(g);
  /*
  g->Draw("A*");
  g->GetXaxis()->SetTitle("Exposure Time (hrs)");
  g->GetYaxis()->SetTitle("Width of Signifiance Distribution");
  g->Fit(fPLTimeFit);
  g0->SetMarkerColor(kBlue);
  g0->Draw("*");
  TLegend* leg = new TLegend(0.7,0.7,0.9,0.9);
  leg->AddEntry(g,"Error in Alpha of 1%","p");
  leg->AddEntry(g0,"No Error in Alpha","p");
  leg->Draw("same");
  */
}

void plotMultiLTWidth()
{
  TGraph* g4pt2bg = plotLongTermWidth(4.2,0.001,0.1);
  TGraph* g1pt7bg = plotLongTermWidth(1.7,0.001,0.1);
  TGraph* g0err = plotLongTermWidth(4.2,0.0,0.1);
  TCanvas* c1 = new TCanvas("c1","",50,50,700,500);
  g4pt2bg->SetMarkerColor(kRed);
  g1pt7bg->SetMarkerColor(kGreen);
  
  g4pt2bg->GetXaxis()->SetTitle("Observation time (hrs)");
  g4pt2bg->GetYaxis()->SetTitle("Width of MC Signifiance Dist.");
  g4pt2bg->Draw("A*");
  g1pt7bg->Draw("*");
  g0err->Draw("*");

  TLegend* leg = new TLegend(0.7,0.7,0.9,0.9);
  leg->AddEntry(g4pt2bg,"Bg rate 4.2/min, Error in Alpha of 1%","p");
  leg->AddEntry(g1pt7bg,"Bg rate 1.7/min, Error in Alpha of 1%","p");
  leg->AddEntry(g0err,"Bg rate 1.7/min, no Error in Alpha","p");
  
  leg->Draw("same");

}

double LiMa5(int Non, int Noff, double alpha)
{
  double Nex = Non - (alpha*Noff);
  double S = Nex/sqrt(Non + (alpha**2.0)*Noff);
  return(S);
}

double LiMa9(int Non, int Noff, double alpha)
{
  double Nex = Non - (alpha*Noff);
  double S = Nex/sqrt(alpha*(Non + Noff));
  return(S);
}
