//C, C++
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include <time.h>

using namespace std;

Int_t plotsmrpcDQP(TString fileN="./hist_TOP.root", TString outFile="./outFileTmp.pdf"){
  cout<<"fileN = "<<fileN<<endl;
  TFile *f1 = new TFile(fileN.Data());
  //----------------------------------
  TH1D *h1_1 = (TH1D*)f1->Get("h1_UnixTime");
  TH1D *h1_2 = (TH1D*)f1->Get("h1_nSignalCh");
  TH1D *h1_3 = (TH1D*)f1->Get("h1_nTotSigCh");
  //----------------------------------
  TH2D *h2_1 = (TH2D*)f1->Get("h2_sigChCorrelation");
  TH2D *h2_2 = (TH2D*)f1->Get("h2_Amplitude_vs_chID");
  TH2D *h2_3 = (TH2D*)f1->Get("h2_MeasuredBaseline_vs_chID");
  TH2D *h2_4 = (TH2D*)f1->Get("h2_LeadingEdgeTime_vs_chID");
  TH2D *h2_5 = (TH2D*)f1->Get("h2_TrailingEdgeTime_vs_chID");
  TH2D *h2_6 = (TH2D*)f1->Get("h2_sigWidth_vs_chID");
  TH2D *h2_7 = (TH2D*)f1->Get("h2_deltaTime_vs_strip");
  TH2D *h2_8 = (TH2D*)f1->Get("h2_sumTime_vs_strip");
  //----------------------------------
  h1_1->SetLineWidth(3.0);
  h1_2->SetLineWidth(3.0);
  h1_3->SetLineWidth(3.0);
  //----------------------------------
  Int_t npixX = 1169;
  Int_t npixY = 827;
  gStyle->SetPalette(1);
  gStyle->SetFrameBorderMode(0);
  gROOT->ForceStyle();
  gStyle->SetStatColor(kWhite);
  //gStyle->SetOptStat(kFALSE);
  /////////////////////////////////////////////////////////////
  TCanvas *c11 = new TCanvas("c11",fileN.Data(),10,10,npixX,npixY);
  c11->SetRightMargin(0.03);
  c11->SetLeftMargin(0.09);
  c11->SetTopMargin(0.03);
  c11->SetBottomMargin(0.09); 
  h1_1->Draw();
  h1_1->GetXaxis()->SetTitle("Time, s");
  TCanvas *c12 = new TCanvas("c12",fileN.Data(),20,20,npixX,npixY);
  c12->SetRightMargin(0.03);
  c12->SetLeftMargin(0.09);
  c12->SetTopMargin(0.03);
  c12->SetBottomMargin(0.09);
  h1_2->Draw();
  h1_2->GetXaxis()->SetTitle("Channel ID");
  TCanvas *c13 = new TCanvas("c13",fileN.Data(),30,30,npixX,npixY);
  c13->SetRightMargin(0.03);
  c13->SetLeftMargin(0.09);
  c13->SetTopMargin(0.03);
  c13->SetBottomMargin(0.09);
  h1_3->Draw();
  h1_3->GetXaxis()->SetTitle("Total number of fired channels");
  /////////////////////////////////////////////////////////////
  TCanvas *c21 = new TCanvas("c21",fileN.Data(),10,10,npixX,npixY);
  //gPad->SetLogz();
  c21->SetRightMargin(0.03);
  c21->SetLeftMargin(0.09);
  c21->SetTopMargin(0.03);
  c21->SetBottomMargin(0.09);
  h2_1->Draw("ZCOLOR");
  h2_1->GetXaxis()->SetTitle("Channel ID");
  h2_1->GetYaxis()->SetTitle("Channel ID");
  TCanvas *c22 = new TCanvas("c22",fileN.Data(),20,20,npixX,npixY);
  gPad->SetLogz();
  c22->SetRightMargin(0.03);
  c22->SetLeftMargin(0.09);
  c22->SetTopMargin(0.03);
  c22->SetBottomMargin(0.09);
  h2_2->Draw("ZCOLOR");
  h2_2->GetXaxis()->SetTitle("Channel ID");
  h2_2->GetYaxis()->SetTitle("Amplitude, V");
  TCanvas *c23 = new TCanvas("c23",fileN.Data(),30,30,npixX,npixY);
  gPad->SetLogz();
  c23->SetRightMargin(0.03);
  c23->SetLeftMargin(0.09);
  c23->SetTopMargin(0.03);
  c23->SetBottomMargin(0.09);
  h2_3->Draw("ZCOLOR");
  h2_3->GetXaxis()->SetTitle("Channel ID");
  h2_3->GetYaxis()->SetTitle("Baseline amplitude, V");
  TCanvas *c24 = new TCanvas("c24",fileN.Data(),40,40,npixX,npixY);
  gPad->SetLogz();
  c24->SetRightMargin(0.03);
  c24->SetLeftMargin(0.09);
  c24->SetTopMargin(0.03);
  c24->SetBottomMargin(0.09);
  h2_4->Draw("ZCOLOR");
  h2_4->GetXaxis()->SetTitle("Channel ID");
  h2_4->GetYaxis()->SetTitle("Leading Edge Time, ns");
  TCanvas *c25 = new TCanvas("c25",fileN.Data(),50,50,npixX,npixY);
  gPad->SetLogz();
  c25->SetRightMargin(0.03);
  c25->SetLeftMargin(0.09);
  c25->SetTopMargin(0.03);
  c25->SetBottomMargin(0.09);
  h2_5->Draw("ZCOLOR");
  h2_5->GetXaxis()->SetTitle("Channel ID");
  h2_5->GetYaxis()->SetTitle("Trailing Edge Time, ns");
  TCanvas *c26 = new TCanvas("c26",fileN.Data(),60,60,npixX,npixY);
  gPad->SetLogz();
  c26->SetRightMargin(0.03);
  c26->SetLeftMargin(0.09);
  c26->SetTopMargin(0.03);
  c26->SetBottomMargin(0.09);
  h2_6->Draw("ZCOLOR");
  h2_6->GetXaxis()->SetTitle("Channel ID");
  h2_6->GetYaxis()->SetTitle("Signal width, ns");
  TCanvas *c27 = new TCanvas("c27",fileN.Data(),70,70,npixX,npixY);
  //gPad->SetLogz();
  c27->SetRightMargin(0.03);
  c27->SetLeftMargin(0.09);
  c27->SetTopMargin(0.03);
  c27->SetBottomMargin(0.09);
  h2_7->Draw("ZCOLOR");
  h2_7->GetXaxis()->SetTitle("Delta tine, ns");
  h2_7->GetYaxis()->SetTitle("Strip ID");
  TCanvas *c28 = new TCanvas("c28",fileN.Data(),80,80,npixX,npixY);
  //gPad->SetLogz();
  c28->SetRightMargin(0.03);
  c28->SetLeftMargin(0.09);
  c28->SetTopMargin(0.03);
  c28->SetBottomMargin(0.09);
  h2_8->Draw("ZCOLOR");
  h2_8->GetXaxis()->SetTitle("Sum tine, ns");
  h2_8->GetYaxis()->SetTitle("Strip ID");
  /////////////////////////////////////////////////////////////
  TString outFileB = outFile; outFileB += "(";
  TString outFileE = outFile; outFileE += ")";
  c11->Print(outFileB.Data(),"pdf");
  c12->Print(outFile.Data(),"pdf");
  c13->Print(outFile.Data(),"pdf");
  c21->Print(outFile.Data(),"pdf");
  c22->Print(outFile.Data(),"pdf");
  c23->Print(outFile.Data(),"pdf");
  c24->Print(outFile.Data(),"pdf");
  c25->Print(outFile.Data(),"pdf");
  c26->Print(outFile.Data(),"pdf");
  c27->Print(outFile.Data(),"pdf");
  c28->Print(outFileE.Data(),"pdf");
  return 0;
}
