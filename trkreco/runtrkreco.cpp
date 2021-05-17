//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Tue Jul 18 11:33:33 CEST 2017                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   Reconstruction of the CORTO track and provide      //
//                   data quality plots.                                //
//                                                                      //
// Input paramete: Compile and run without parameters for help          //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

//my
#include "src/trkreco.hh"

//root
#include "TROOT.h"
#include "TString.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TFile.h"
#include "TRandom3.h"
#include "TGraph.h"

//C, C++
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <iomanip>
#include <time.h>

using namespace std;

int main(int argc, char *argv[]){
  if(argc == 9 && atoi(argv[1])==0){
    //--------------------------------------//
    // Data quality histogramming for CORTO //
    //--------------------------------------//
    TString rootFilesListTOP = argv[2];
    TString rootFilesListMID = argv[3];
    TString rootFilesListBOT = argv[4];    
    TString mrpcClibConstTOP = argv[5];
    TString mrpcClibConstMID = argv[6];
    TString mrpcClibConstBOT = argv[7];
    TString outRootFileHist  = argv[8];
    cout<<"--> trkreco::trkDQH <--"<<endl
	<<"rootFilesTOP : "<<rootFilesListTOP<<endl
	<<"rootFilesMID : "<<rootFilesListMID<<endl
	<<"rootFilesBOT : "<<rootFilesListBOT<<endl;
    cout<<"mrpcClibConstTOP : "<<mrpcClibConstTOP<<endl
	<<"mrpcClibConstMID : "<<mrpcClibConstMID<<endl
	<<"mrpcClibConstBOT : "<<mrpcClibConstBOT<<endl
	<<"outRootFileHist  : "<<outRootFileHist<<endl;
    trkreco a( rootFilesListTOP, rootFilesListMID, rootFilesListBOT, 
    	       mrpcClibConstTOP, mrpcClibConstMID, mrpcClibConstBOT);
    a.trkDQH(outRootFileHist);
  }
  else if(argc == 5 && atoi(argv[1])==1){
    //-----------------//
    // Not implemented //
    //-----------------//
    cout<<" ERROR ---> NOT IMPLEMENTED "<<endl;
    assert(0);
  }
  else{
    cout<<" trkreco::trkDQH (Data quality histogramming for track reconstruction)"<<endl
	<<" runID [1] = 0 (execution ID number)"<<endl
      	<<"       [2] - Name of root files list with L1 files for TOP MRPC"<<endl
      	<<"       [3] - Name of root files list with L1 files for MID MRPC"<<endl
      	<<"       [4] - Name of root files list with L1 files for BOT MRPC"<<endl;
    cout<<"       [5] - File with MRPC clibration constants (TOP)"<<endl
      	<<"       [6] - File with MRPC clibration constants (MID)"<<endl
      	<<"       [7] - File with MRPC clibration constants (BOT)"<<endl
	<<"       [8] - Output histogram full path"<<endl;
    cout<<" NOT IMPLEMENTED "<<endl
	<<" runID [1] = 1 (execution ID number)"<<endl;
  }
  return 0;
}
