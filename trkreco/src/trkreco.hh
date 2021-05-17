//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Tue Jul 18 11:33:33 CEST 2017                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   Cass to reconstruct the CORTO track and provide    //
//                   data quality plots.                                //
//                                                                      //
// Input paramete:                                                      //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

#ifndef trkreco_hh
#define trkreco_hh

//My
#include "trkrecobase.hh"

//root
#include <TROOT.h>

//My
class mrpc;
struct mrpchit;

//root
class TChain;
class TFile;
class TTree;
class TString;
class TBranch;

class trkreco: public trkrecobase {
public:
  trkreco(TString fileListTOP, TString fileListMID, TString fileListBOT,
	  TString mrpcClibConstFileTOP, TString mrpcClibConstFileMID, TString mrpcClibConstFileBOT) 
    : trkrecobase( fileListTOP, fileListMID, fileListBOT,  
		   mrpcClibConstFileTOP, mrpcClibConstFileMID, mrpcClibConstFileBOT) 
  {
  }
  
  void trkDQH(TString histOut);
  void trk();
  Int_t getXYintersectionWithBottomMRPC( Double_t &xbotInt, Double_t &ybotInt, mrpchit *hitT, mrpchit *hitM, mrpchit *hitB);
  Int_t getXYintersectionWithBottomMRPC2( Double_t &xbotInt, Double_t &ybotInt, mrpchit *hitT, mrpchit *hitM, mrpchit *hitB);
};

#endif
