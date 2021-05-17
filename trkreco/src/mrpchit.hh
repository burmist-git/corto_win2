//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Tue Jul 18 11:58:29 CEST 2017                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   MRPC data structure.                               //
//                                                                      //
// Input paramete:                                                      //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

#ifndef mrpchit_hh
#define mrpchit_hh 1

#include <TROOT.h>

struct mrpchit
{
  Long64_t evID;
  Double_t evUnixTime;
  ULong64_t TDCint64usbwc;
  Int_t hitstatus;
  Float_t pozxyz[3];
  //Float_t hittime[2];
  //Int_t TrackID;
  //Int_t HitID;
  mrpchit() :
    evID(-999),
    evUnixTime(-999.0),
    TDCint64usbwc(0),
    hitstatus(0),
    pozxyz{-999.0,-999.0,-999.0}
    //pozxyz[1](-999.0),
    //pozxyz[2](-999.0)
  {;}
  ~mrpchit() {;}  
};

#endif
