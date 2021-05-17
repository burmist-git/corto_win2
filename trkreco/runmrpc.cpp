//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Fri Oct  7 01:27:05 CEST 2016                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   Data quality histogramming for single MRPC.        //
//                                                                      //
// Input paramete: Compile and run without parameters for help          //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//////////////////////////////////////////////////////////////////////////

//my
#include "src/mrpc.hh"

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
  if(argc == 4 && atoi(argv[1])==0){
    //-----------------//
    // Not implemented //
    //-----------------//
    TString rootFilesList = argv[2];
    TString outRootFileF = argv[3];
    cout<<"--> mrpc::Loop <--"<<endl
	<<"                 dummy loop "<<endl
	<<"rootFilesList : "<<rootFilesList<<endl
	<<"outRootFileF  : "<<outRootFileF<<endl;
    mrpc a(rootFilesList);
    a.Loop(outRootFileF);
  }
  else if(argc == 5 && atoi(argv[1])==1){
    //--------------------------------------------//
    // Data quality histogramming for single MRPC //
    //--------------------------------------------//
    TString mrpcCalibConst = argv[2];
    TString rootFilesList = argv[3];
    TString histOut = argv[4];
    cout<<"--> mrpc::mrpcDQH <--"<<endl
	<<"mrpcCalibConst : "<<mrpcCalibConst<<endl
	<<"rootFilesList : "<<rootFilesList<<endl
	<<"histOut       : "<<histOut<<endl;
    mrpc a(rootFilesList);
    a.SetMRPCdTcalibration(mrpcCalibConst);
    //a.printMRPCdTcalibration();
    a.mrpcDQH(histOut);
  }
  else{
    cout<<" mrpc::Loop (Not implemented, dummy loop) "<<endl
	<<" runID [1] = 0 (execution ID number)"<<endl
      	<<"       [2] - file with list of the root files from L1"<<endl
	<<"       [3] - output histogram full path"<<endl;
    cout<<" mrpc::mrpcDQH (Data quality histogramming for single MRPC) "<<endl
	<<" runID [1] = 1 (execution ID number)"<<endl
      	<<"       [2] - file with MRPC clibration constants"<<endl
      	<<"       [3] - file with list of the root files from L1"<<endl
	<<"       [4] - output histogram full path"<<endl;
  }
  return 0;
}
