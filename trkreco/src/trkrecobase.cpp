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

//my
#include "trkrecobase.hh"
#include "mrpc.hh"

//root
//#include <TH2.h>
//#include <TStyle.h>
//#include <TCanvas.h>
#include <TString.h>
//#include <TChain.h>
//#include <TFile.h>
//#include <TTree.h>
//#include <TBranch.h>
//#include <TH1D.h>
//#include <TH2D.h>
//#include <TGraph.h>

//C, C++
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <iomanip>
#include <time.h>
//#include <bits/stdc++.h>

using namespace std;

trkrecobase::trkrecobase(TString fileListTOP, TString fileListMID, TString fileListBOT,
			 TString mrpcClibConstFileTOP, TString mrpcClibConstFileMID, TString mrpcClibConstFileBOT){
  mrpcT = new mrpc(fileListTOP);
  mrpcT->SetMRPCIndex(0);
  mrpcM = new mrpc(fileListMID);
  mrpcM->SetMRPCIndex(1);
  mrpcB = new mrpc(fileListBOT);
  mrpcB->SetMRPCIndex(2);
  mrpcT->SetMRPCdTcalibration(mrpcClibConstFileTOP);
  mrpcM->SetMRPCdTcalibration(mrpcClibConstFileMID);
  mrpcB->SetMRPCdTcalibration(mrpcClibConstFileBOT);
}

trkrecobase::~trkrecobase(){
  delete mrpcT;
  delete mrpcM;
  delete mrpcB;
}
