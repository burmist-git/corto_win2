//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Fri Oct  7 01:27:05 CEST 2016                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   Base cass to read L1 root file from single MRPC    //
//                   and perform analysis of measurements               //
//                                                                      //
// Input paramete:                                                      //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

//my
#include "mrpcbase.hh"

//root
#include <TH2.h>
#include <TStyle.h>
#include <TCanvas.h>
#include <TString.h>
#include <TChain.h>
#include <TFile.h>
#include <TTree.h>
#include <TBranch.h>
#include <TH1D.h>
#include <TH2D.h>
#include <TGraph.h>

//C, C++
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <iomanip>
#include <time.h>
#include <bits/stdc++.h>
using namespace std;

mrpcbase::mrpcbase(TString fileList) : fChain(0) 
{
  readEnv();
  ifstream indata;
  TString rootFileName;
  TChain *theChain = new TChain("T");
  indata.open(fileList.Data()); 
  assert(indata.is_open());  
  while (indata  >> rootFileName ){
    if(indata.eof()){
      std::cout<<"EOF"<<std::endl;
      break;
    }
    cout<<"        adding "<<rootFileName<<endl;
    theChain->Add(rootFileName.Data(),-1);
  }
  indata.close();
  Init(theChain);
  for(Int_t i = 0;i<_nMRPCstripMax;i++)
    _mrpcCalibdTconst[i] = 0.0;
  defCORTOpar();
}

mrpcbase::mrpcbase(Int_t mrpcIndex, TString fileName) : fChain(0) //V.YE. 8.09
{
  readEnv();
  TChain *theChain = new TChain("T");
  theChain->Add(fileName.Data(),-1);
  Init(theChain);
  for(Int_t i = 0;i<_nMRPCstripMax;i++)
    _mrpcCalibdTconst[i] = 0.0;
  SetMRPCIndex(mrpcIndex);
  defCORTOpar();
}

void mrpcbase::defCORTOpar(){
  _sigVel = 8.8967;        //cm/ns
  _stripWidth = 2.5;       //cm
  _gapWidth = 0.7;         //cm
  _mrpcCenterX = 65.5;     //cm
  _mrpcCenterY = 100;      //cm
  _mrpcTopZ = 358.75;      //cm
  _mrpcMidZ = 208.25;      //cm
  _mrpcBotZ = 2.75;        //cm
  //SetMRPCdTcalibration()
}

mrpcbase::~mrpcbase(){
   if (!fChain) return;
   delete fChain->GetCurrentFile();
}

Long64_t mrpcbase::GetNumberOfEntries(){
  return fChain->GetEntriesFast();
}

void mrpcbase::Loop(TString histOut){
}

void mrpcbase::SetMRPCdTcalibration(TString mrpcCalibConstFile){
  TString mot;
  Int_t stID;
  Double_t dT;
  ifstream myfile(mrpcCalibConstFile.Data());
  if (myfile.is_open()){
    myfile>>mot>>mot;
    for(Int_t i = 0;i<_nMRPCstripMax;i++){
      myfile>>stID>>dT;
      _mrpcCalibdTconst[i] = dT;
    }
    myfile.close();
  }
  else{
    cout << "Unable to open file : "<<mrpcCalibConstFile<<endl; 
    assert(0);
  }
}

void mrpcbase::printMRPCdTcalibration(){
  for(Int_t i = 0;i<_nMRPCstripMax;i++){
    cout<<setw(10)<<i<<setw(10)<<_mrpcCalibdTconst[i]<<endl;
  }
}

Int_t mrpcbase::GetEntry(Long64_t entry){
  // Read contents of entry.
  if (!fChain) return 0;
  return fChain->GetEntry(entry);
}

void mrpcbase::loadEvent(Long64_t il){
  Long64_t nentries = fChain->GetEntriesFast();
  if(il>=nentries){
    cout<<" ---> ERROR : nentries>=il"<<endl
	<<"              nentries = "<<nentries<<endl
	<<"                    il = "<<il<<endl;
    assert(0);
  }
  Long64_t nbytes = 0, nb = 0;
  Long64_t ientry = LoadTree(il);
  nb = fChain->GetEntry(il); nbytes += nb;
}

Long64_t mrpcbase::LoadTree(Long64_t entry){
  // Set the environment to read one entry
  if (!fChain) return -5;
  Long64_t centry = fChain->LoadTree(entry);
  if (centry < 0) return centry;
  if (fChain->GetTreeNumber() != fCurrent) {
    fCurrent = fChain->GetTreeNumber();
    Notify();
  }
  return centry;
}

void mrpcbase::Init(TTree *tree){
  // The Init() function is called when the selector needs to initialize
  // a new tree or chain. Typically here the branch addresses and branch
  // pointers of the tree will be set.
  // It is normally not necessary to make changes to the generated
  // code, but the routine can be extended by the user if needed.
  // Init() will be called many times when running on PROOF
  // (once per file to be processed).
  // Set branch addresses and branch pointers
  if (!tree) return;
  fChain = tree;
  fCurrent = -1;
  fChain->SetMakeClass(1);
  //fChain->SetBranchAddress("evt", &evt, &b_evt);
  //fChain->SetBranchAddress("run", &run, &b_run);
  //fChain->SetBranchAddress("pValue", &pValue, &b_pValue);
  //...
  //...
  //
  //---------------------------------------------------
  // ADD HERE :
  fChain->SetBranchAddress("eventID", &eventID, &b_eventID);
  fChain->SetBranchAddress("UnixTime", &UnixTime, &b_UnixTime);
  fChain->SetBranchAddress("TDCint64usbwc", &TDCint64usbwc, &b_TDCint64usbwc);
  fChain->SetBranchAddress("nChusbwc", &nChusbwc, &b_nChusbwc);
  fChain->SetBranchAddress("EventIDsamIndex", EventIDsamIndex, &b_EventIDsamIndex);
  fChain->SetBranchAddress("MeasuredBaseline", MeasuredBaseline, &b_MeasuredBaseline);
  fChain->SetBranchAddress("Amplitude", Amplitude, &b_Amplitude);
  fChain->SetBranchAddress("Charge", Charge, &b_Charge);
  fChain->SetBranchAddress("LeadingEdgeTime", LeadingEdgeTime, &b_LeadingEdgeTime);
  fChain->SetBranchAddress("TrailingEdgeTime", TrailingEdgeTime, &b_TrailingEdgeTime);
  fChain->SetBranchAddress("RateCounter", RateCounter, &b_RateCounter);
  //---------------------------------------------------
  Notify();
}

Bool_t mrpcbase::Notify(){
  // The Notify() function is called when a new file is opened. This
  // can be either for a new TTree in a TChain or when when a new TTree
  // is started when using PROOF. It is normally not necessary to make changes
  // to the generated code, but the routine can be extended by the
  // user if needed. The return value is currently not used.
  return kTRUE;
}

void mrpcbase::Show(Long64_t entry){
  // Print contents of entry.
  // If entry is not specified, print current entry
  if (!fChain) return;
  fChain->Show(entry);
}

Int_t mrpcbase::Cut(Long64_t entry){
  // This function may be called from Loop.
  // returns  1 if entry is accepted.
  // returns -1 otherwise.
  return 1;
}

Double_t mrpcbase::GetUnixTimeStop(){
  Long64_t nentries = fChain->GetEntriesFast();
  Long64_t nbytes = 0, nb = 0;
  Long64_t jentry = nentries-1;
  Long64_t ientry = LoadTree(jentry);
  //cout<<"ientry "<<ientry<<endl;
  nb = fChain->GetEntry(jentry);   nbytes += nb;
  return UnixTime;
}

Double_t mrpcbase::GetUnixTimeStart(){
  Long64_t nbytes = 0, nb = 0;
  Long64_t jentry=0;
  Long64_t ientry = LoadTree(jentry);
  //cout<<"ientry "<<ientry<<endl;
  nb = fChain->GetEntry(jentry);   nbytes += nb;
  return UnixTime;
}

void mrpcbase::readEnv(){
  char *tmp;
  TString cortoWinEnvName;
  //CORTOWINMRPCNCH
  cortoWinEnvName = "CORTOWINMRPCNCH";
  tmp = getenv(cortoWinEnvName.Data());
  if(tmp == NULL){
    cout<<" ---> ERROR : environment variable "<<cortoWinEnvName<<endl
	<<"              please use this command > . setupCORTOWINworkspace.bash"<<endl
	<<"              to define environment variable for CORTO data treatment."<<endl;
    assert(0);
  }
  else{
    _nMRPCch = atoi(tmp);
  }
  //CORTOWINMRPCSIGTHRES
  cortoWinEnvName = "CORTOWINMRPCSIGTHRES";
  tmp = getenv(cortoWinEnvName.Data());
  if(tmp == NULL){
    cout<<" ---> ERROR : environment variable "<<cortoWinEnvName<<endl
	<<"              please use this command > . setupCORTOWINworkspace.bash"<<endl
	<<"              to define environment variable for CORTO data treatment."<<endl;
    assert(0);
  }
  else{
    _mrpcAmplThreshold = atof(tmp);
  }
  //CORTOWINMRPCSIGBASELINECUT
  cortoWinEnvName = "CORTOWINMRPCSIGBASELINECUT";
  tmp = getenv(cortoWinEnvName.Data());
  if(tmp == NULL){
    cout<<" ---> ERROR : environment variable "<<cortoWinEnvName<<endl
	<<"              please use this command > . setupCORTOWINworkspace.bash"<<endl
	<<"              to define environment variable for CORTO data treatment."<<endl;
    assert(0);
  }
  else{
    _mrpcBaseLineWindow = atof(tmp);
  }
  //CORTOWINMRPCNST
  cortoWinEnvName = "CORTOWINMRPCNST";
  tmp = getenv(cortoWinEnvName.Data());
  if(tmp == NULL){
    cout<<" ---> ERROR : environment variable "<<cortoWinEnvName<<endl
	<<"              please use this command > . setupCORTOWINworkspace.bash"<<endl
	<<"              to define environment variable for CORTO data treatment."<<endl;
    assert(0);
  }
  else{
    _nMRPCstrip = atoi(tmp);
  }


  /////////////////////////////////////////
  if(_nMRPCch!=_nMRPCchMax){
    cout<<" ---> ERROR : _nMRPCch    != _nMRPCchMax"<<endl
	<<"              _nMRPCch    = "<<_nMRPCch<<endl
	<<"              _nMRPCchMax = "<<_nMRPCchMax<<endl;
    assert(0);
  }
  if(_nMRPCstrip!=_nMRPCstripMax){
    cout<<" ---> ERROR : _nMRPCstrip    != _nMRPCstripMax"<<endl
	<<"              _nMRPCstrip    = "<<_nMRPCstrip<<endl
	<<"              _nMRPCstripMax = "<<_nMRPCstripMax<<endl;
    assert(0);
  }
  // cout<<"CORTOWINMRPCNCH            = "<<_nMRPCch<<endl
  //  <<"CORTOWINMRPCNST            = "<<_nMRPCstrip<<endl
  //  <<"CORTOWINMRPCSIGTHRES       = "<<_mrpcAmplThreshold<<endl
  //  <<"CORTOWINMRPCSIGBASELINECUT = "<<_mrpcBaseLineWindow<<endl;
}

void mrpcbase::h1D1Init(TH1D *h1D1[_nMRPCchMax],TString h1name, TString h1Title,
			   Int_t Nbin, Float_t Vmin, Float_t Vmax){
  Int_t i;
  TString h1nameh;
  TString h1Titleh;
  for(i = 0;i<_nMRPCchMax;i++){    
    h1nameh = h1name; h1nameh += "_"; h1nameh += "ch_"; h1nameh += i;
    h1Titleh = h1Title; h1nameh += " "; h1Titleh += "ch "; h1Titleh += i;
    h1D1[i] = new TH1D(h1nameh.Data(), h1Titleh.Data(),
                       Nbin, Vmin, Vmax);
  }
}

void mrpcbase::h1D1InitStrip(TH1D *h1D1[_nMRPCstripMax],TString h1name, TString h1Title,
				Int_t Nbin, Float_t Vmin, Float_t Vmax){
  Int_t i;
  TString h1nameh;
  TString h1Titleh;
  for(i = 0;i<_nMRPCstripMax;i++){    
    h1nameh = h1name; h1nameh += "_"; h1nameh += "st_"; h1nameh += i;
    h1Titleh = h1Title; h1nameh += " "; h1Titleh += "st "; h1Titleh += i;
    h1D1[i] = new TH1D(h1nameh.Data(), h1Titleh.Data(),
                       Nbin, Vmin, Vmax);
  }
}

void mrpcbase::tGraphInit(TGraph *gr[_nMRPCchMax], TString grName, TString grTitle){
  Int_t i;
  TString grNameh;
  TString grTitleh;
  for(i = 0;i<_nMRPCchMax;i++){
    grNameh = grName; grNameh += "_"; grNameh += "ch_"; grNameh += i;
    grTitleh = grTitle; grTitleh += " "; grTitleh += "ch "; grTitleh += i;
    gr[i] = new TGraph();
    gr[i]->SetTitle(grTitleh.Data());
    gr[i]->SetName(grNameh.Data());
  }
}

void mrpcbase::h2D2Init(TH2D *h2D2[_nMRPCchMax],TString h2name, TString h2Title,
			   Int_t Nbin1, Float_t Vmin1, Float_t Vmax1,
			   Int_t Nbin2, Float_t Vmin2, Float_t Vmax2){
  Int_t i;
  TString h2nameh;
  TString h2Titleh;
  for(i = 0;i<_nMRPCchMax;i++){    
    h2nameh = h2name; h2nameh += "_"; h2nameh += "ch_"; h2nameh += i;
    h2Titleh = h2Title; h2nameh += " "; h2Titleh += "ch "; h2Titleh += i;
    h2D2[i] = new TH2D(h2nameh.Data(), h2Titleh.Data(),
		       Nbin1, Vmin1, Vmax1,
		       Nbin2, Vmin2, Vmax2);
  }
}


