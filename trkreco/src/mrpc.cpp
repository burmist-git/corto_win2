//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Fri Oct  7 01:27:05 CEST 2016                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   Cass to read L1 root file from single MRPC         //
//                   and perform analysis of measurements               //
//                                                                      //
// Input paramete:                                                      //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

//my
#include "mrpc.hh"
#include "mrpchit.hh"

//root
#include <TH2.h>
#include <TStyle.h>
#include <TCanvas.h>
#include <TString.h>
#include <TChain.h>
#include <TFile.h>
#include <TTree.h>
#include <TBranch.h>

//C, C++
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <iomanip>
#include <time.h>
#include <bits/stdc++.h>

using namespace std;

void mrpc::Loop(TString histOut){
}

void mrpc::recomrpchit(Long64_t il, mrpchit *hit){
  hit->evID = -999;
  hit->evUnixTime = -999.0;
  hit->TDCint64usbwc = 0;
  hit->hitstatus = 0;
  hit->pozxyz[0] = -999.0;
  hit->pozxyz[1] = -999.0;
  hit->pozxyz[2] = -999.0;
  loadEvent(il);  
  Float_t xHit = -999.0;
  Float_t yHit = -999.0;
  Float_t zHit = -999.0;
  //Float_t tLeftHit = 0.0;
  //Float_t tRigtHit = 0.0;
  //V.YE. 8.09.17
  Float_t deltaTime = 0;
  Float_t deltaTimeCorr = 0;
  Int_t nTotSigCh = 0;
  Double_t stripX0 = _mrpcCenterX - _nMRPCstripMax/2 * _stripWidth - (_nMRPCstripMax/2 + 0.5) * _gapWidth;
  Int_t mrpcChannelMap[_nMRPCchMax];
  Int_t j = 0;
  Int_t i = 0;
  Double_t sumTime;
  Double_t sigWidth = -999.0;
  /////////////////////////////////
  //      Loop over channels     //
  /////////////////////////////////
  for(j = 0;j<_nMRPCchMax;j++)
    mrpcChannelMap[j] = 0;
  for(i = 0;i<_nMRPCchMax;i++){
    if(Amplitude[i]>_mrpcAmplThreshold){
      //cout<<"_mrpcAmplThreshold = "<<_mrpcAmplThreshold<<endl;
      //assert(0);
      nTotSigCh++;
      if(MeasuredBaseline[i]<_mrpcBaseLineWindow){
	if(MeasuredBaseline[i]>-_mrpcBaseLineWindow){
	  if(TrailingEdgeTime[i]>130 && TrailingEdgeTime[i]<230){
	    if(LeadingEdgeTime[i]>150 && LeadingEdgeTime[i]<250){
	      sigWidth = TrailingEdgeTime[i] - LeadingEdgeTime[i];
	      if(sigWidth > 10 && sigWidth < 25){
		mrpcChannelMap[i] = 1;
	      }
	    }
	  }
	} //if(MeasuredBaseline[i]>-_mrpcBaseLineWindow)
      }//if(MeasuredBaseline[i]<_mrpcBaseLineWindow)
    }//if(Amplitude[i]>_mrpcAmplThreshold)
  }//for(i = 0;i<_nMRPCchMax;i++)  
  /////////////////////////////////
  /////////////////////////////////
  //       Loop over strips      //
  /////////////////////////////////
  hit->evID = eventID;
  hit->evUnixTime = UnixTime;
  hit->TDCint64usbwc = TDCint64usbwc;
  for(i = 0;i<_nMRPCstripMax;i++){
    if(mrpcChannelMap[2*i] == 1 && mrpcChannelMap[2*i+1] == 1){ // Cut on quality of individual channel
      if(nTotSigCh == 2){ // Cut on number of signal strips
	deltaTime = LeadingEdgeTime[2*i] - LeadingEdgeTime[2*i+1];
		
	xHit = _stripWidth * (i + 0.5) + _gapWidth * i + stripX0;
	if (_mrpcIndex == 0) {
	  deltaTimeCorr = LeadingEdgeTime[2*i] - LeadingEdgeTime[2*i+1] - _mrpcCalibdTconst[i];
	  yHit = _mrpcCenterY + _sigVel * deltaTimeCorr ;
	  zHit = _mrpcTopZ; }
	else if (_mrpcIndex == 1){ 
	  deltaTimeCorr = LeadingEdgeTime[2*i] - LeadingEdgeTime[2*i+1] - _mrpcCalibdTconst[i];
	  yHit = _mrpcCenterY + _sigVel * deltaTimeCorr ;
	  zHit = _mrpcMidZ;}
	else if (_mrpcIndex == 2){ 
	  deltaTimeCorr = LeadingEdgeTime[2*i+1] - LeadingEdgeTime[2*i] - _mrpcCalibdTconst[i];
	  yHit = _mrpcCenterY + _sigVel * deltaTimeCorr ;
	  zHit = _mrpcBotZ;}
	else
	  assert(0);
	hit->hitstatus = 1;
	hit->pozxyz[0] = xHit;
	hit->pozxyz[1] = yHit;
	hit->pozxyz[2] = zHit;
	//sumTime = LeadingEdgeTime[2*i] + LeadingEdgeTime[2*i+1];
      }// if(nTotSigCh == 2){ // Cut on number of signal strisp
    }//if(mrpcChannelMap[2*i] == 1 && mrpcChannelMap[2*i+1] == 1){ // Cut on quality of individual channel
  }//for(i = 0;i<_nMRPCstripMax;i++){  
  /////////////////////////////////
}//void mrpc::recomrpchit(Long64_t il, mrpchit *hit)

void mrpc::mrpcDQH(TString histOut){
  Double_t utStop  = GetUnixTimeStop();
  Double_t utStart = GetUnixTimeStart();
  Double_t deltaUT = utStop - utStart;
  //cout<<"deltaUT = "<<deltaUT<< " s" <<endl;  
  //Double_t dT_trigg_m_CpFM;
  Int_t i = 0;
  Int_t j = 0;
  Double_t sigWidth = 0.0;
  Double_t deltaTime = 0.0;
  Double_t deltaTimeCorr = 0.0;
  Double_t yPos = 0.0;
  Double_t xPos = 0.0;
  Double_t sumTime = 0.0;
  ////////////////// Channel Histograms //////////////////
  TH1D *h1_UnixTime = new TH1D("h1_UnixTime","UnixTime. Number of events per 100 s",(Int_t)deltaUT/100,0,deltaUT);
  TH1D *h1_nSignalCh = new TH1D("h1_nSignalCh","nSignalCh",_nMRPCchMax,-0.5,_nMRPCchMax-1+0.5);
  TH1D *h1_nTotSigCh = new TH1D("h1_nTotSigCh","nTotSigCh",_nMRPCchMax+1,-0.5,_nMRPCchMax+0.5);
  TH2D *h2_Amplitude_vs_chID = new TH2D("h2_Amplitude_vs_chID","Amplitude vs chID",3*_nMRPCchMax,-0.5,_nMRPCchMax - 1 +0.5,200,-0.05,0.4);
  TH2D *h2_MeasuredBaseline_vs_chID = new TH2D("h2_MeasuredBaseline_vs_chID","MeasuredBaseline vs chID",3*_nMRPCchMax,-0.5,_nMRPCchMax - 1 +0.5,200,-1.3,1.3);
  TH2D *h2_LeadingEdgeTime_vs_chID = new TH2D("h2_LeadingEdgeTime_vs_chID","LeadingEdgeTime vs chID",3*_nMRPCchMax,-0.5,_nMRPCchMax - 1 +0.5,350,-20.0,330);
  TH2D *h2_TrailingEdgeTime_vs_chID = new TH2D("h2_TrailingEdgeTime_vs_chID","TrailingEdgeTime vs chID",3*_nMRPCchMax,-0.5,_nMRPCchMax - 1 +0.5,350,-20.0,330);
  TH2D *h2_sigWidth_vs_chID = new TH2D("h2_sigWidth_vs_chID","sigWidth vs chID",3*_nMRPCchMax,-0.5,_nMRPCchMax - 1 +0.5,300,-20,100);
  TH2D *h2_sigChCorrelation = new TH2D("h2_sigChCorrelation","sigChCorrelation",_nMRPCchMax,-0.5,_nMRPCchMax-1+0.5,_nMRPCchMax,-0.5,_nMRPCchMax-1+0.5);
  TH1D *h1_EventIDsamIndex[_nMRPCchMax];
  TH1D *h1_MeasuredBaseline[_nMRPCchMax];
  TH1D *h1_Amplitude[_nMRPCchMax];
  TH1D *h1_Charge[_nMRPCchMax];
  TH1D *h1_LeadingEdgeTime[_nMRPCchMax];
  TH1D *h1_TrailingEdgeTime[_nMRPCchMax];
  TH1D *h1_RateCounter[_nMRPCchMax];
  TH1D *h1_sigWidth[_nMRPCchMax];
  Int_t mrpcChannelMap[_nMRPCchMax];
  Int_t nTotSigCh = 0;
  h1D1Init(h1_EventIDsamIndex,"h1_EventIDsamIndex","EventIDsamIndex",1000,-1,300);
  h1D1Init(h1_MeasuredBaseline,"h1_MeasuredBaseline","MeasuredBaseline",1000,-1.5,1.5);
  h1D1Init(h1_Amplitude,"h1_Amplitude","Amplitude",1000,-1.5,1.5);
  h1D1Init(h1_Charge,"h1_Charge","Charge",40000,-1000,1000);
  h1D1Init(h1_LeadingEdgeTime,"h1_LeadingEdgeTime","LeadingEdgeTime",8000,0.0,400);
  h1D1Init(h1_TrailingEdgeTime,"h1_TrailingEdgeTime","TrailingEdgeTime",8000,0.0,400);
  h1D1Init(h1_RateCounter,"h1_RateCounter","RateCounter,",1000,0.0,10000);
  h1D1Init(h1_sigWidth,"h1_sigWidth","sigWidth,",300,-20,100);
  ////////////////////////////////////////////////////////////
  ///////////////////// Strip Histograms /////////////////////
  TH2D *h2_deltaTime_vs_strip = new TH2D("h2_deltaTime_vs_strip","strip vs deltaTime",400, -40, 40,3*_nMRPCstripMax,-0.5,_nMRPCstripMax-1+0.5);
  TH2D *h2_deltaTimeCorr_vs_strip = new TH2D("h2_deltaTimeCorr_vs_strip","strip vs deltaTime",400, -40, 40,3*_nMRPCstripMax,-0.5,_nMRPCstripMax-1+0.5);
  TH2D *h2_sumTime_vs_strip = new TH2D("h2_sumTime_vs_strip","strip vs sumTime",650, 0, 650,3*_nMRPCstripMax,-0.5,_nMRPCstripMax-1+0.5);
  TH1D *h1_deltaTime[_nMRPCstripMax];
  TH1D *h1_sumTime[_nMRPCstripMax];
  h1D1InitStrip(h1_deltaTime,"h1_deltaTime","delta Time", 400, -200, 200);
  h1D1InitStrip(h1_sumTime,"h1_sumTime","sum Time", 650, 0, 650);
  ////////////////////////////////////////////////////////////
  Long64_t nentries = fChain->GetEntriesFast();
  cout<<"nentries = "<<nentries<<endl;
  Long64_t nbytes = 0, nb = 0;
  for(Long64_t jentry=0; jentry<nentries;jentry++){
    Long64_t ientry = LoadTree(jentry);
    if (ientry < 0) break;
    nb = fChain->GetEntry(jentry);   nbytes += nb;
    // if (Cut(ientry) < 0) continue;
    for(j = 0;j<_nMRPCchMax;j++)
      mrpcChannelMap[j] = 0;
    nTotSigCh = 0;
    h1_UnixTime->Fill(UnixTime - utStart);
    for(i = 0;i<_nMRPCchMax;i++){
      sigWidth = TrailingEdgeTime[i] - LeadingEdgeTime[i];
      h1_EventIDsamIndex[i]->Fill(EventIDsamIndex[i]);
      h1_MeasuredBaseline[i]->Fill(MeasuredBaseline[i]);
      h1_Amplitude[i]->Fill(Amplitude[i]);
      h1_Charge[i]->Fill(Charge[i]);
      h1_LeadingEdgeTime[i]->Fill(LeadingEdgeTime[i]);
      h1_TrailingEdgeTime[i]->Fill(TrailingEdgeTime[i]);
      h1_RateCounter[i]->Fill(RateCounter[i]);
      h1_sigWidth[i]->Fill(sigWidth);
      h2_Amplitude_vs_chID->Fill(i,Amplitude[i]);
      h2_MeasuredBaseline_vs_chID->Fill(i,MeasuredBaseline[i]);
      h2_LeadingEdgeTime_vs_chID->Fill(i,LeadingEdgeTime[i]);
      h2_TrailingEdgeTime_vs_chID->Fill(i,TrailingEdgeTime[i]);
      h2_sigWidth_vs_chID->Fill(i,sigWidth);
      ////////////////////////////////////
      if(Amplitude[i]>_mrpcAmplThreshold){
	if(MeasuredBaseline[i]<_mrpcBaseLineWindow){
	  if(MeasuredBaseline[i]>-_mrpcBaseLineWindow){
	    h1_nSignalCh->Fill(i);
	    mrpcChannelMap[i] = 1;
	    nTotSigCh++;
	  }
	} 
      }
      ////////////////////////////////////
    }//for(i = 0;i<_nMRPCchMax;i++){
    h1_nTotSigCh->Fill(nTotSigCh);
    /////////////////////////////////
    //  Second loop over channels  //
    /////////////////////////////////
    for(i = 0;i<_nMRPCchMax;i++){
      if(mrpcChannelMap[i] == 1){
	for(j = 0;j<_nMRPCchMax;j++){
	  if(mrpcChannelMap[j] == 1)
	    h2_sigChCorrelation->Fill(i,j);
	}
      }
    }//for(i = 0;i<_nMRPCchMax;i++){
    /////////////////////////////////
    /////////////////////////////////
    //       Loop over strips      //
    /////////////////////////////////
    for(i = 0;i<_nMRPCstripMax;i++){
      if(mrpcChannelMap[2*i] == 1 && mrpcChannelMap[2*i+1] == 1){ // Cut on quality of individual channel
	deltaTime = LeadingEdgeTime[2*i] - LeadingEdgeTime[2*i+1];
	deltaTimeCorr = LeadingEdgeTime[2*i] - LeadingEdgeTime[2*i+1] - _mrpcCalibdTconst[i];
	//Double_t yPos = 0.0;
	//Double_t xPos = 0.0;
	sumTime = LeadingEdgeTime[2*i] + LeadingEdgeTime[2*i+1];
	h1_deltaTime[i]->Fill(deltaTime);
	h1_sumTime[i]->Fill(sumTime);
	h2_deltaTime_vs_strip->Fill(deltaTime,i);
	h2_sumTime_vs_strip->Fill(sumTime,i);
      }//if(mrpcChannelMap[2*i] == 1 && mrpcChannelMap[2*i+1] == 1){ // Cut on quality of individual channel
    }//for(i = 0;i<_nMRPCstripMax;i++){
    /////////////////////////////////
  }//for(Long64_t jentry=0; jentry<nentries;jentry++){
  TFile* rootFile = new TFile(histOut.Data(), "RECREATE", " Histograms", 1);
  rootFile->cd();
  if (rootFile->IsZombie()){
    cout<<"  ERROR ---> file "<<histOut.Data()<<" is zombi"<<endl;
    assert(0);
  }
  else
    cout<<"  Output Histos file ---> "<<histOut.Data()<<endl;
  for(i = 0;i<_nMRPCchMax;i++){
    h1_EventIDsamIndex[i]->Write();
    h1_MeasuredBaseline[i]->Write();
    h1_Amplitude[i]->Write();
    h1_Charge[i]->Write();
    h1_LeadingEdgeTime[i]->Write();
    h1_TrailingEdgeTime[i]->Write();
    h1_RateCounter[i]->Write();
    h1_sigWidth[i]->Write();
  }
  for(i = 0;i<_nMRPCstripMax;i++){
    h1_deltaTime[i]->Write();
    h1_sumTime[i]->Write();
  }
  h1_UnixTime->Write();
  h1_nSignalCh->Write();
  h1_nTotSigCh->Write();
  h2_Amplitude_vs_chID->Write();
  h2_MeasuredBaseline_vs_chID->Write();
  h2_LeadingEdgeTime_vs_chID->Write();
  h2_TrailingEdgeTime_vs_chID->Write();
  h2_sigWidth_vs_chID->Write();
  h2_sigChCorrelation->Write();
  h2_deltaTime_vs_strip->Write();
  h2_sumTime_vs_strip->Write();
  cout<<endl<<endl;
}
