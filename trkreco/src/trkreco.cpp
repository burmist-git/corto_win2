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

//my
#include "trkreco.hh"
#include "mrpc.hh"
#include "mrpchit.hh"

//root
#include <TH1.h>
#include <TH2.h>
#include <TStyle.h>
#include <TCanvas.h>
#include <TString.h>
#include <TChain.h>
#include <TFile.h>
#include <TTree.h>
#include <TBranch.h>
#include <TMath.h>

//C, C++
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <iomanip>
#include <time.h>
#include <bits/stdc++.h>

using namespace std;

void trkreco::trkDQH(TString histOut){
  Long64_t nEnT=mrpcT->GetNumberOfEntries();
  Long64_t nEnM=mrpcM->GetNumberOfEntries();
  Long64_t nEnB=mrpcB->GetNumberOfEntries();
  if( nEnT != nEnM || nEnT != nEnB){
    cout<<" ---> ERROR  "<<endl;
    cout<<"nEnT "<<nEnT<<endl
	<<"nEnM "<<nEnM<<endl
	<<"nEnB "<<nEnB<<endl;    
    assert(0);
  }
  Long64_t il = 0;
  cout<<"nEnT = "<<nEnT<<endl;
  //cout<<"hitT->evID          "<<hitT->evID<<endl
  //  <<"hitT->evUnixTime    "<<hitT->evUnixTime<<endl
  //  <<"hitT->TDCint64usbwc "<<hitT->TDCint64usbwc<<endl
  //  <<"hitT->pozxyz[0]     "<<hitT->pozxyz[0]<<endl
  //  <<"hitT->pozxyz[1]     "<<hitT->pozxyz[1]<<endl
  //  <<"hitT->pozxyz[2]     "<<hitT->pozxyz[2]<<endl;

  //TH2D *h2_deltaTime_vs_strip = new TH2D("h2_deltaTime_vs_strip","strip vs deltaTime",400, -40, 40,3*_nMRPCstripMax,-0.5,_nMRPCstripMax-1+0.5);
  //TH2D *h2_deltaTimeCorr_vs_strip = new TH2D("h2_deltaTimeCorr_vs_strip","strip vs deltaTime",400, -40, 40,3*_nMRPCstripMax,-0.5,_nMRPCstripMax-1+0.5);

  Double_t xMin = 0;
  Double_t xMax = 130;
  Double_t yMin = 0;
  Double_t yMax = 200;
  Double_t zMin = -10;
  Double_t zMax = 400;
  Int_t nXbin = 100;
  Int_t nYbin = 300;
  Int_t nZbin = 100;

  TH1D *h1_x_T = new TH1D("h1_x_T","x top",nXbin,xMin,xMax);
  TH1D *h1_y_T = new TH1D("h1_y_T","y top",nYbin,yMin,yMax);
  TH1D *h1_z_T = new TH1D("h1_z_T","z top",nZbin,zMin,zMax);
  TH1D *h1_x_M = new TH1D("h1_x_M","x mid",nXbin,xMin,xMax);
  TH1D *h1_y_M = new TH1D("h1_y_M","y mid",nYbin,yMin,yMax);
  TH1D *h1_z_M = new TH1D("h1_z_M","z bot",nZbin,zMin,zMax);
  TH1D *h1_x_B = new TH1D("h1_x_B","x bot",nXbin,xMin,xMax);
  TH1D *h1_y_B = new TH1D("h1_y_B","y bot",nYbin,yMin,yMax);
  TH1D *h1_z_B = new TH1D("h1_z_B","z bot",nZbin,zMin,zMax);

  TH1D *h1_x_T_cut = new TH1D("h1_x_T_cut","x top cut",nXbin,xMin,xMax);
  TH1D *h1_y_T_cut = new TH1D("h1_y_T_cut","y top cut",nYbin,yMin,yMax);
  TH1D *h1_z_T_cut = new TH1D("h1_z_T_cut","z top cut",nZbin,zMin,zMax);
  TH1D *h1_x_M_cut = new TH1D("h1_x_M_cut","x mid cut",nXbin,xMin,xMax);
  TH1D *h1_y_M_cut = new TH1D("h1_y_M_cut","y mid cut",nYbin,yMin,yMax);
  TH1D *h1_z_M_cut = new TH1D("h1_z_M_cut","z bot cut",nZbin,zMin,zMax);
  TH1D *h1_x_B_cut = new TH1D("h1_x_B_cut","x bot cut",nXbin,xMin,xMax);
  TH1D *h1_y_B_cut = new TH1D("h1_y_B_cut","y bot cut",nYbin,yMin,yMax);
  TH1D *h1_z_B_cut = new TH1D("h1_z_B_cut","z bot cut",nZbin,zMin,zMax);

  TH1D *h1_xbotInt = new TH1D("h1_xbotInt","xbotInt",nXbin*2,xMin*2,xMax*2);
  TH1D *h1_ybotInt = new TH1D("h1_ybotInt","ybotInt",nYbin*2,yMin*2,yMax*2);

  TH1D *h1_DxbotInt = new TH1D("h1_DxbotInt","delta xbotInt",nXbin*2,-xMax/2.0,xMax/2.0);
  TH1D *h1_DybotInt = new TH1D("h1_DybotInt","delta ybotInt",nYbin*2,-yMax/2.0,yMax/2.0);  

  TH2D *h2_y_vs_x_T = new TH2D("h2_y_vs_x_T","y vs x TOP",nXbin,xMin,xMax,nYbin,yMin,yMax);
  TH2D *h2_y_vs_x_M = new TH2D("h2_y_vs_x_M","y vs x MID",nXbin,xMin,xMax,nYbin,yMin,yMax);
  TH2D *h2_y_vs_x_B = new TH2D("h2_y_vs_x_B","y vs x BOT",nXbin,xMin,xMax,nYbin,yMin,yMax);

  TH2D *h2_y_vs_x_T_cut = new TH2D("h2_y_vs_x_T_cut","y vs x TOP cut",nXbin,xMin,xMax,nYbin,yMin,yMax);
  TH2D *h2_y_vs_x_M_cut = new TH2D("h2_y_vs_x_M_cut","y vs x MID cut",nXbin,xMin,xMax,nYbin,yMin,yMax);
  TH2D *h2_y_vs_x_B_cut = new TH2D("h2_y_vs_x_B_cut","y vs x BOT cut",nXbin,xMin,xMax,nYbin,yMin,yMax);

  Int_t nT = 0;
  Int_t nM = 0;
  Int_t nB = 0;
  Int_t nTMBcut = 0;

  Double_t utStart = 0;
  Double_t utStop = 0;

  Double_t dUT = 0;

  Double_t xbotInt = 0.0;
  Double_t ybotInt = 0.0;

  for( il = 0; il<nEnT; il++){

    mrpchit *hitT = new mrpchit();
    mrpchit *hitM = new mrpchit();
    mrpchit *hitB = new mrpchit();

    if(il%100000==0)
      cout<<il<<endl;
    mrpcT->recomrpchit(il, hitT);
    mrpcM->recomrpchit(il, hitM);
    mrpcB->recomrpchit(il, hitB);
    if(il == 0)
      utStart = hitT->evUnixTime;
    if(il == (nEnT-1))
      utStop = hitT->evUnixTime;

    if(hitT->hitstatus == 1){
      h1_x_T->Fill(hitT->pozxyz[0]);
      h1_y_T->Fill(hitT->pozxyz[1]);
      h1_z_T->Fill(hitT->pozxyz[2]);
      h2_y_vs_x_T->Fill(hitT->pozxyz[0],hitT->pozxyz[1]);
      nT++;
    }
    if(hitM->hitstatus == 1){
      h1_x_M->Fill(hitM->pozxyz[0]);
      h1_y_M->Fill(hitM->pozxyz[1]);
      h1_z_M->Fill(hitM->pozxyz[2]);
      h2_y_vs_x_M->Fill(hitM->pozxyz[0],hitM->pozxyz[1]);
      nM++;
    }
    if(hitB->hitstatus == 1){
      h1_x_B->Fill(hitB->pozxyz[0]);
      h1_y_B->Fill(hitB->pozxyz[1]);
      h1_z_B->Fill(hitB->pozxyz[2]);
      h2_y_vs_x_B->Fill(hitB->pozxyz[0],hitB->pozxyz[1]);
      nB++;
    }
    if( hitT->evID != hitM->evID || hitT->evID != hitB->evID){
      if( hitT->TDCint64usbwc != hitM->TDCint64usbwc || hitT->TDCint64usbwc != hitB->TDCint64usbwc){
	cout<<" ---> ERROR "<<endl;
	cout<<"hitT->evID "<<hitT->evID<<endl
	    <<"hitM->evID "<<hitM->evID<<endl
	    <<"hitB->evID "<<hitB->evID<<endl;    
	assert(0);
      }//if( hitT->TDCint64usbwc != hitM->TDCint64usbwc || hitT->TDCint64usbwc != hitB->TDCint64usbwc){
      assert(0);
    }//if( hitT->evID != hitM->evID || hitT->evID != hitB->evID){     
    if(hitT->hitstatus == 1){
      if(hitM->hitstatus == 1){
	if(hitB->hitstatus == 1){	    
	  h1_x_T_cut->Fill(hitT->pozxyz[0]);
	  h1_y_T_cut->Fill(hitT->pozxyz[1]);
	  h1_z_T_cut->Fill(hitT->pozxyz[2]);
	  h1_x_M_cut->Fill(hitM->pozxyz[0]);
	  h1_y_M_cut->Fill(hitM->pozxyz[1]);
	  h1_z_M_cut->Fill(hitM->pozxyz[2]);
	  h1_x_B_cut->Fill(hitB->pozxyz[0]);
	  h1_y_B_cut->Fill(hitB->pozxyz[1]);
	  h1_z_B_cut->Fill(hitB->pozxyz[2]);
	  h2_y_vs_x_T_cut->Fill(hitT->pozxyz[0],hitT->pozxyz[1]);
	  h2_y_vs_x_M_cut->Fill(hitM->pozxyz[0],hitM->pozxyz[1]);
	  h2_y_vs_x_B_cut->Fill(hitB->pozxyz[0],hitB->pozxyz[1]);
	  nTMBcut++;
	  if(getXYintersectionWithBottomMRPC2( xbotInt, ybotInt, hitT, hitM, hitB) == 1){
	    h1_xbotInt->Fill(xbotInt);
	    h1_ybotInt->Fill(ybotInt);

	    h1_DxbotInt->Fill(xbotInt - hitB->pozxyz[0]);
	    h1_DybotInt->Fill(ybotInt - hitB->pozxyz[1]);

	  }
	}
      }
    }
    delete hitT;
    delete hitM;
    delete hitB;
  }//  for( il = 0; il<nEnT; il++){

  dUT = utStop - utStart;

  TFile* rootFile = new TFile(histOut.Data(), "RECREATE", " Histograms", 1);
  rootFile->cd();
  if (rootFile->IsZombie()){
    cout<<"  ERROR ---> file "<<histOut.Data()<<" is zombi"<<endl;
    assert(0);
  }
  else
    cout<<"  Output Histos file ---> "<<histOut.Data()<<endl;

  h1_x_T->Write();
  h1_y_T->Write();
  h1_z_T->Write();
  h1_x_M->Write();
  h1_y_M->Write();
  h1_z_M->Write();
  h1_x_B->Write();
  h1_y_B->Write();
  h1_z_B->Write();
  
  h1_x_T_cut->Write();
  h1_y_T_cut->Write();
  h1_z_T_cut->Write();
  h1_x_M_cut->Write();
  h1_y_M_cut->Write();
  h1_z_M_cut->Write();
  h1_x_B_cut->Write();
  h1_y_B_cut->Write();
  h1_z_B_cut->Write();

  h1_xbotInt->Write();
  h1_ybotInt->Write();	  

  h1_DxbotInt->Write();	  
  h1_DybotInt->Write();

  h2_y_vs_x_T->Write();
  h2_y_vs_x_M->Write();
  h2_y_vs_x_B->Write();

  h2_y_vs_x_T_cut->Write();
  h2_y_vs_x_M_cut->Write();
  h2_y_vs_x_B_cut->Write();

  cout<<"nEnT    = "<<nEnT<<endl
      <<"nT      = "<<nT<<endl
      <<"nM      = "<<nM<<endl
      <<"nB      = "<<nB<<endl
      <<"nTMBcut = "<<nTMBcut<<endl;

  cout<<"utStart    = "<<utStart<<endl
      <<"utStop     = "<<utStop<<endl
      <<"dUT        = "<<dUT<<endl;
}

Int_t trkreco::getXYintersectionWithBottomMRPC( Double_t &xbotInt, Double_t &ybotInt, mrpchit *hitT, mrpchit *hitM, mrpchit *hitB){
  
  Double_t t = TMath::Sqrt((hitM->pozxyz[0] - hitT->pozxyz[0])*(hitM->pozxyz[0] - hitT->pozxyz[0]) + 
			   (hitM->pozxyz[1] - hitT->pozxyz[1])*(hitM->pozxyz[1] - hitT->pozxyz[1]) + 
			   (hitM->pozxyz[2] - hitT->pozxyz[2])*(hitM->pozxyz[2] - hitT->pozxyz[2]));
  Double_t vx = 0.0;
  Double_t vy = 0.0;
  Double_t vz = 0.0;

  xbotInt = -999.0;
  ybotInt = -999.0;

  if(t == 0.0){
    xbotInt = -999.0;
    ybotInt = -999.0;
    return 0;
  }

  vx = (hitM->pozxyz[0] - hitT->pozxyz[0])/t;
  vy = (hitM->pozxyz[1] - hitT->pozxyz[1])/t;
  vz = (hitM->pozxyz[2] - hitT->pozxyz[2])/t;

  if(vz == 0.0){
    xbotInt = -999.0;
    ybotInt = -999.0;
    return 0;
  }

  Double_t tint = (hitB->pozxyz[2] - hitT->pozxyz[2])/vz;

  xbotInt = hitT->pozxyz[0] + vx*tint;
  ybotInt = hitT->pozxyz[1] + vy*tint;

  return 1;
}

void trkreco::trk(){
  //cout<<"trkreco::trk"<<endl;
}

Int_t trkreco::getXYintersectionWithBottomMRPC2( Double_t &xbotInt, Double_t &ybotInt, mrpchit *hitT, mrpchit *hitM, mrpchit *hitB){
  
  Double_t t = (hitB->pozxyz[2] - hitT->pozxyz[2])/(hitM->pozxyz[2] - hitT->pozxyz[2]);
  
  xbotInt = -999.0;
  ybotInt = -999.0;

  xbotInt = hitT->pozxyz[0] + t * (hitM->pozxyz[0] - hitT->pozxyz[0]);
  ybotInt = hitT->pozxyz[1] + t * (hitM->pozxyz[1] - hitT->pozxyz[1]);
  
  return 1;
}
