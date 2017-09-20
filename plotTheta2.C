// A macro to make a publication-quality theta2 plot from a stage6 file.
// Simply specify the stage6 file and adjust your theta2 cut value.

void plot_thtsq(TString file_name)
{

	///////////////////////////////////////////////
	// User: configure this section for your source
	
	//TString file_name = "/a/home/tehanu/dribeiro/Analysis/Crab/stage6/res_All-med-com-disp_olds6.root";
	
	double theta2cut = 0.01;
	
	// end source configuration section
	///////////////////////////////////////////////
	
	std::cout << file_name << std::endl;
	
	TFile* histo_file = new TFile(file_name);
	
	TH1F* thtsq_on = dynamic_cast<TH1F*>(histo_file->Get("WobbleAnalysis/WTheTA"));
	TH1F* thtsq_off = dynamic_cast<TH1F*>(histo_file->Get("WobbleAnalysis/WTheTAoff"));
	
	//thtsq_off->Scale(11.);
	//thtsq_on->Rebin(8);
	//thtsq_off->Rebin(8);
	
	int nBins = thtsq_on->GetNbinsX();
	int plot_min = 100000;
	int plot_max = 0;
	
	for(int i = 1; i <= nBins; i++)
	{
	
		if(thtsq_on->GetBinLowEdge(i) > 0.2)
		{
			break;
		}
		
		if((thtsq_on->GetBinContent(i) + thtsq_on->GetBinError(i)) > plot_max)
		{
			plot_max = thtsq_on->GetBinContent(i) + thtsq_on->GetBinError(i);
		}
		if((thtsq_off->GetBinContent(i) + thtsq_off->GetBinError(i)) > plot_max)
		{
			plot_max = thtsq_off->GetBinContent(i) + thtsq_off->GetBinError(i);
		}
		
		if(thtsq_on->GetBinContent(i) < plot_min)
		{
			plot_min = thtsq_on->GetBinContent(i);
		}
		if(thtsq_off->GetBinContent(i) < plot_min)
		{
			plot_min = thtsq_off->GetBinContent(i);
		}
	}
	
	std::cout << plot_min << " " << plot_max << std::endl;
	
	if(plot_min < 200)
	{
		plot_min = 0;
	}
	if(plot_min >= 200)
	{
		plot_min = 0.8 * plot_min;
	}
	plot_max = 1.2 * plot_max;
	
  //TH1F* thtsq_excess = (TH1F*)thtsq_on->Clone("Excess");
  //thtsq_excess->Sumw2();
  //thtsq_excess = thtsq_excess->Add(thtsq_off,-1.0);
	
	/* Fit to Power Law (Canvas Declared Here Intentionally)*/
	gROOT->SetStyle("Plain");
	gStyle->SetCanvasColor(10);
	gStyle->SetOptStat(000000);
	gStyle->SetOptTitle(0);
	gStyle->SetEndErrorSize(0);
	
	TCanvas* sc_thsq = new TCanvas("sc_thsq", "Pretty Stuff", 2);
	sc_thsq->cd();
	sc_thsq->SetTickx();
	sc_thsq->SetTicky();
	sc_thsq->SetLeftMargin(0.15);
	sc_thsq->SetRightMargin(0.05);
	sc_thsq->SetTopMargin(0.025);
	sc_thsq->SetBottomMargin(0.125);
	
	thtsq_off->SetAxisRange(plot_min, plot_max, "Y");
	thtsq_off->SetAxisRange(0., 0.199, "X");
	thtsq_off->SetXTitle("#theta^{2} [ deg^{2} ]");
	
	thtsq_off->SetYTitle("Events");
	thtsq_off->SetTitleSize(0.05, "X");
	thtsq_off->SetTitleSize(0.05, "Y");
	thtsq_off->SetTitleOffset(1.5, "Y");
	thtsq_off->SetTitleOffset(1.0, "X");
	thtsq_off->SetLabelSize(0.05, "X");
	thtsq_off->SetLabelSize(0.05, "Y");
	thtsq_off->SetNdivisions(505);
	thtsq_off->SetFillColor(17);
	thtsq_off->SetLineColor(1);
	thtsq_off->SetLineWidth(1);
	thtsq_off->GetXaxis()->SetLabelFont(42);
	thtsq_off->GetYaxis()->SetLabelFont(42);
	thtsq_off->GetZaxis()->SetLabelFont(42);
	thtsq_off->GetXaxis()->SetTitleFont(42);
	thtsq_off->GetYaxis()->SetTitleFont(42);
	thtsq_off->GetZaxis()->SetTitleFont(42);
	thtsq_off->SetTitleFont(42);
	thtsq_off->Draw("hist");
	
	thtsq_on->Draw("pesame");
	thtsq_on->SetLineWidth(3);
	thtsq_on->SetLineColor(1);
	thtsq_on->SetMarkerStyle(8);
	thtsq_on->SetMarkerSize(1.1);
	thtsq_on->SetMarkerColor(1);
	thtsq_on->Draw("pesame");

	//TLine* cut_line = new TLine(0.01,plot_min,0.01,plot_max);
	TLine* cut_line = new TLine(theta2cut, plot_min, theta2cut, plot_max);
	//  TLine* cut_line = new TLine(0.0125,plot_min,0.0125,plot_max);
	cut_line->SetLineStyle(2);
	cut_line->SetLineWidth(3);
	cut_line->Draw();
	
	TLegend* leg = new TLegend(0.65, 0.70, 0.90, 0.90);
	leg->AddEntry(thtsq_on, "Source", "el");
	leg->AddEntry(thtsq_off, "Background", "f");
	leg->SetFillColor(kWhite);
	leg->SetBorderSize(0);
	leg->Draw();
	
}

