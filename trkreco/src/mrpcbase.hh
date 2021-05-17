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

#ifndef mrpcbase_hh
#define mrpcbase_hh

#include <TROOT.h>

class TChain;
class TFile;
class TTree;
class TString;
class TBranch;
class TH1D;
class TH2D;
class TGraph;

static const Int_t _nMRPCchMax=48;
static const Int_t _nMRPCstripMax=24;

class mrpcbase {

public :  
  mrpcbase(Int_t mrpcIndex, TString fileName); //V.YE. 8.09.17 
  mrpcbase(TString fileList);
  ~mrpcbase();
  Int_t GetEntry(Long64_t entry);
  Long64_t GetNumberOfEntries();
  Long64_t LoadTree(Long64_t entry);
  void Init(TTree *tree);
  void Loop(TString histOut);
  Bool_t Notify();
  void Show(Long64_t entry = -1);
  Int_t Cut(Long64_t entry);
  Double_t GetUnixTimeStop();
  Double_t GetUnixTimeStart();
  void loadEvent(Long64_t il);
  void readEnv();
  void SetMRPCdTcalibration(TString mrpcCalibConstFile);
  void printMRPCdTcalibration();
  void h1D1Init(TH1D *h1D1[_nMRPCchMax],TString h1name, TString h1Title,
                Int_t Nbin, Float_t Vmin, Float_t Vmax);
  void h1D1InitStrip(TH1D *h1D1[_nMRPCstripMax],TString h1name, TString h1Title,
		     Int_t Nbin, Float_t Vmin, Float_t Vmax);
  void tGraphInit(TGraph *gr[_nMRPCchMax], TString grName, TString grTitle);
  void h2D2Init(TH2D *h2D2[_nMRPCchMax],TString h2name, TString h2Title,
		Int_t Nbin1, Float_t Vmin1, Float_t Vmax1,
		Int_t Nbin2, Float_t Vmin2, Float_t Vmax2);  
  //void tProfInit(TProfile *tprof[_nMRPCchMax],TString h1name, TString h1Title,
  //              Int_t Nbin1, Float_t Vmin1, Float_t Vmax1);
  void SetMRPCIndex(Int_t mrpcid) {_mrpcIndex = mrpcid;}; //0 for TOP, 1 for MID, 2 for BOT MRPC
  void defCORTOpar();
protected :
  TTree          *fChain;   //!pointer to the analyzed TTree or TChain
  Int_t           fCurrent; //!current Tree number in a TChain
  //Int_t           evt;
  //Int_t           run;
  //Float_t         pValue;
  //...
  //...
  //
  //---------------------------------------------------
  // ADD HERE :
  // Declaration of leaf types
  Int_t           eventID;
  Double_t        UnixTime;
  ULong64_t       TDCint64usbwc;
  Int_t           nChusbwc;
  Int_t           EventIDsamIndex[_nMRPCchMax];
  Float_t         MeasuredBaseline[_nMRPCchMax];
  Float_t         Amplitude[_nMRPCchMax];
  Float_t         Charge[_nMRPCchMax];
  Float_t         LeadingEdgeTime[_nMRPCchMax];
  Float_t         TrailingEdgeTime[_nMRPCchMax];
  Float_t         RateCounter[_nMRPCchMax];
  //---------------------------------------------------
  
  // List of branches
  //TBranch        *b_evt;
  //TBranch        *b_run;
  //TBranch        *b_pValue;
  //...
  //...
  //
  //---------------------------------------------------
  // ADD HERE :
  // List of branches
  TBranch        *b_eventID;
  TBranch        *b_UnixTime;
  TBranch        *b_TDCint64usbwc;
  TBranch        *b_nChusbwc;
  TBranch        *b_EventIDsamIndex;
  TBranch        *b_MeasuredBaseline;
  TBranch        *b_Amplitude;
  TBranch        *b_Charge;
  TBranch        *b_LeadingEdgeTime;
  TBranch        *b_TrailingEdgeTime;
  TBranch        *b_RateCounter;
  //---------------------------------------------------
  Int_t _mrpcIndex; //0 for TOP, 1 for MID, 2 for BOT MRPC
  Int_t _nMRPCch;
  Int_t _nMRPCstrip;
  Double_t _mrpcAmplThreshold;
  Double_t _mrpcBaseLineWindow;
  Double_t _mrpcCalibdTconst[_nMRPCstripMax];
  Double_t _stripWidth;
  Double_t _gapWidth;
  Double_t _mrpcCenterX;
  Double_t _mrpcCenterY;
  Double_t _mrpcTopZ;
  Double_t _mrpcMidZ;
  Double_t _mrpcBotZ;
  Double_t _sigVel;
  TString _calibConstFile;

};

#endif
