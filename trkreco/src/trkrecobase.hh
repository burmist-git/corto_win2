//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Tue Jul 18 11:33:33 CEST 2017                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   Base Cass to reconstruct the CORTO track and       //
//                   provide data quality plots.                        //
//                                                                      //
// Input paramete:                                                      //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

#ifndef trkrecobase_hh
#define trkrecobase_hh

#include <TROOT.h>

//class TChain;
//class TFile;
//class TTree;
class TString;
class mrpc;
//class TBranch;
//class TH1D;
//class TH2D;
//class TGraph;

class trkrecobase {

public :
  trkrecobase(TString fileListTOP, TString fileListMID, TString fileListBOT,
	      TString mrpcClibConstFileTOP, TString mrpcClibConstFileMID, TString mrpcClibConstFileBOT);
  ~trkrecobase();
  
protected :
  Int_t           eventID;
  Double_t        UnixTime;
  ULong64_t       TDCint64usbwc;

  mrpc *mrpcT;
  mrpc *mrpcM;
  mrpc *mrpcB;
  
};

#endif
