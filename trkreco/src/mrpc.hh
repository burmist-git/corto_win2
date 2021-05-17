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

#ifndef mrpc_hh
#define mrpc_hh

//My
#include "mrpcbase.hh"

//root
#include <TROOT.h>

class TChain;
class TFile;
class TTree;
class TString;
class TBranch;
struct mrpchit;

class mrpc: public mrpcbase {
public:
  mrpc(TString fileList) : mrpcbase(fileList)
  {
  }

  mrpc(Int_t mrpcIndex, TString fileList) : mrpcbase(mrpcIndex, fileList) //V.YE. 8.09.17
  {
  }
  
  void Loop(TString histOut);
  void mrpcDQH(TString histOut);
  void recomrpchit(Long64_t il, mrpchit *hit);

};

#endif
