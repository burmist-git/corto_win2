//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Fri Oct  7 01:27:05 CEST 2016                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   Convertion of the binary data into the root        //
//                   format. Initial binary data file produced          //
//                   by the 48 channel USB-WaveCatcher.                 //
//                                                                      //
// Input paramete: Compile and run without parameters for help          //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//////////////////////////////////////////////////////////////////////////

//root
#include <TH1D.h>
#include <TStyle.h>
#include <TString.h>
#include <TCanvas.h>
#include <TFile.h>
#include <TTree.h>
#include <TMath.h>

//C, C++
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include <stdlib.h>

using namespace std;

const Int_t nCh = 48;
const Int_t nMaxDataFiles = 100000;
const Int_t numberOfHeaderLines = 5;
const Int_t verboseLevel = 1;

//const Int_t nPointMax = 100000;
//const Int_t nSegmentsMax = 100000;//per file

void convertUSBWCMeas2root8ChannelsBin(TString fileN, TString rootFileN);

int main(int argc, char *argv[] ){
  if(argc == 4 && atoi(argv[1]) == 0){
    TString fileN = argv[2];
    TString rootFileN = argv[3];
    if(verboseLevel >= 1){
      cout<<endl
	  <<" Input data file  : "<<fileN<<endl
	  <<" Output root file : "<<rootFileN<<endl<<endl;
    }
    convertUSBWCMeas2root8ChannelsBin(fileN, rootFileN);
  }
  else if(argc == 5 && atoi(argv[1]) == 1){
    TString dataFileList = argv[2];
    TString datPreff = argv[3];
    TString rootPreff = argv[4];
    if(verboseLevel >= 1){
      cout<<endl
	  <<" File containing the list of input data files : "<<dataFileList<<endl
	  <<" Path of the directory containing these input files : "<<datPreff<<endl
	  <<" Path of the directory containing the output files : "<<rootPreff<<endl<<endl;
    }
    ifstream indataFileList;
    string mot;
    indataFileList.open(dataFileList.Data()); 
    assert(indataFileList.is_open());
    //export CORTOWINL1ROOTFSUFFIX="_L1.root"
    TString fileN; 
    TString rootFileN;
    char* pPath;
    pPath = getenv("CORTOWINL1ROOTFSUFFIX");
    //TString L1ROOTFSUFFIX = "_L1.root";
    TString L1ROOTFSUFFIX=pPath;
    while (indataFileList >> mot){
      fileN = datPreff + "/" + mot;
      rootFileN = rootPreff + "/" + mot + L1ROOTFSUFFIX;
      if(verboseLevel >= 1){
	cout<<" ---> Conversion            "<<fileN<<endl;
	cout<<" ---> Out root file "<<rootFileN<<endl;
      }
      convertUSBWCMeas2root8ChannelsBin(fileN, rootFileN);
    }      
    indataFileList.close();
  }
  else{
    cout<<endl
    	<<"  ERROR ---> in input arguments "<<endl
    	<<"             [1] : runID = 0 "<<endl
    	<<"             [2] : Input data file"<<endl
    	<<"             [3] : Output root file"<<endl;
    cout<<"             ----------------------"<<endl;
    cout<<"             [1] : runID = 1 "<<endl
    	<<"             [2] : name of a text file containing the list of binary files with measurements to be converted to ROOT"<<endl
    	<<"             [3] : path of the directory containing the input USBWC files"<<endl
    	<<"             [4] : path of the directory containing the output ROOT files"<<endl;
  }
  return 0;
}

//void convertUSBWCMeas2root8ChannelsBin(TString dataFileList,
//			                 TString datPreff, 
//			                 TString rootFileN){
void convertUSBWCMeas2root8ChannelsBin(TString fileN, 
				       TString rootFileN){
  FILE *pFile;
  long totFileSizeByte;
  long currentPositionByte;
  char *buffer;
  TString buffTmp;

  int EventNumber;
  double EpochTime;
  unsigned int Year;
  unsigned int Month;
  unsigned int Day;
  unsigned int Hour;
  unsigned int Minute;
  unsigned int Second;
  unsigned int Millisecond;
  int channel;
  int EventIDsamIndexV;
  float	MeasuredBaselineV[nCh];
  float	AmplitudeValue[nCh];
  float	ComputedCharge[nCh];
  float	RiseTimeInstant[nCh];
  float	FallTimeInstant[nCh];
  float	RawTriggerRate[nCh];
  float floatR;
  unsigned long long int TDCint64;

  Int_t EventNumber_usbwc;
  Double_t EpochTime_usbwc;
  Int_t Year_usbwc;
  Int_t Month_usbwc;
  Int_t Day_usbwc;
  Int_t Hour_usbwc;
  Int_t Minute_usbwc;
  Int_t Second_usbwc;
  Int_t Millisecond_usbwc;
  Int_t channel_usbwc;
  Int_t EventIDsamIndex_usbwc;
  Float_t MeasuredBaseline_usbwc[nCh];
  Float_t AmplitudeValue_usbwc[nCh];
  Float_t ComputedCharge_usbwc[nCh];
  Float_t RiseTimeInstant_usbwc[nCh];
  Float_t FallTimeInstant_usbwc[nCh];
  Float_t RawTriggerRate_usbwc[nCh];
  Int_t nCh_usbwc = nCh;
  //USBWC data in one ev//
  Int_t eventID;
  Double_t UnixTime;
  ULong64_t TDCint64usbwc;
  Int_t nChusbwc = nCh_usbwc;
  Int_t EventIDsamIndex[nCh];
  Float_t MeasuredBaseline[nCh];
  Float_t Amplitude[nCh];
  Float_t Charge[nCh];
  Float_t LeadingEdgeTime[nCh];
  Float_t TrailingEdgeTime[nCh];
  Float_t RateCounter[nCh];
  TFile *hfile = new TFile( rootFileN, "RECREATE", "Data", 1);
  if (hfile->IsZombie()) {
    cout << "PROBLEM with the initialization of the output ROOT ntuple " 
	 << rootFileN << ": check that the path is correct!!!"
	 << endl;
    exit(-1);
  }
  TTree *tree = new TTree("T", "Data Tree");
  hfile->SetCompressionLevel(2);
  tree->SetAutoSave(1000000);
  // Create new event
  TTree::SetBranchStyle(0);
  //Event
  // 16.02.2015 new form of the event - same as in convertUSBWCMeas2root8Channels
  //tree->Branch("EventNumber_usbwc",&EventNumber_usbwc, "EventNumber_usbwc/I");
  //tree->Branch("EpochTime_usbwc",&EpochTime_usbwc, "EpochTime_usbwc/D");
  //tree->Branch("Year_usbwc",&Year_usbwc, "Year_usbwc/I");
  //tree->Branch("Month_usbwc",&Month_usbwc, "Month_usbwc/I");
  //tree->Branch("Day_usbwc",&Day_usbwc, "Day_usbwc/I");
  //tree->Branch("Hour_usbwc",&Hour_usbwc, "Hour_usbwc/I");
  //tree->Branch("Minute_usbwc",&Minute_usbwc, "Minute_usbwc/I");
  //tree->Branch("Second_usbwc",&Second_usbwc, "Second_usbwc/I");
  //tree->Branch("Millisecond_usbwc",&Millisecond_usbwc, "Millisecond_usbwc/I");
  //tree->Branch("nCh_usbwc",&nCh_usbwc, "nCh_usbwc/I");
  //tree->Branch("MeasuredBaseline_usbwc", MeasuredBaseline_usbwc, "MeasuredBaseline_usbwc[nCh_usbwc]/F");
  //tree->Branch("AmplitudeValue_usbwc", AmplitudeValue_usbwc, "AmplitudeValue_usbwc[nCh_usbwc]/F");
  //tree->Branch("ComputedCharge_usbwc", ComputedCharge_usbwc, "ComputedCharge_usbwc[nCh_usbwc]/F");
  //tree->Branch("RiseTimeInstant_usbwc", RiseTimeInstant_usbwc, "RiseTimeInstant_usbwc[nCh_usbwc]/F");
  //tree->Branch("FallTimeInstant_usbwc", FallTimeInstant_usbwc, "FallTimeInstant_usbwc[nCh_usbwc]/F");
  //tree->Branch("RawTriggerRate_usbwc", RawTriggerRate_usbwc, "RawTriggerRate_usbwc[nCh_usbwc]/F");
  //Event USBWC
  tree->Branch("eventID",&eventID, "eventID/I");
  tree->Branch("UnixTime",&UnixTime, "UnixTime/D");
  tree->Branch("TDCint64usbwc",&TDCint64usbwc, "TDCint64usbwc/l");
  tree->Branch("nChusbwc",&nChusbwc, "nChusbwc/I");
  tree->Branch("EventIDsamIndex",EventIDsamIndex, "EventIDsamIndex[nChusbwc]/I");
  tree->Branch("MeasuredBaseline", MeasuredBaseline, "MeasuredBaseline[nChusbwc]/F");
  tree->Branch("Amplitude", Amplitude, "Amplitude[nChusbwc]/F");
  tree->Branch("Charge", Charge, "Charge[nChusbwc]/F");
  tree->Branch("LeadingEdgeTime", LeadingEdgeTime, "LeadingEdgeTime[nChusbwc]/F");
  tree->Branch("TrailingEdgeTime", TrailingEdgeTime, "TrailingEdgeTime[nChusbwc]/F");
  tree->Branch("RateCounter",RateCounter ,"RateCounter[nChusbwc]/F");

  Int_t i,j;

  //Int_t headerSize = 409;
  Int_t headerSize = 0;

  if(verboseLevel >= 2)
    cout<<"fileN "<<fileN<<endl;
  //-----------------------
  //--->> READ HEADER <<---
  //-----------------------
  //-----------------------
  //--->> READ number of header symbols <<---
  if(verboseLevel >= 2)
    cout<<" ---> READ number of header symbols <--- "<<endl;
  string line;
  ifstream myfile (fileN.Data());
  headerSize = 0;
  if(myfile.is_open()){
    for(j = 0;j<numberOfHeaderLines;j++){
      getline (myfile,line);
      if(verboseLevel >= 2)
	cout << line <<"  line.length() = "<<line.length()<< '\n';
      headerSize = headerSize + line.length();
    }
    myfile.close();
  }
  //-----------------------
  headerSize = headerSize+numberOfHeaderLines;
  if(verboseLevel >= 2)
    cout<<"headerSize "<<headerSize<<endl<<endl;
  //assert(0);
  pFile = fopen (fileN.Data(), "rb" );
  if (pFile==NULL) {fputs ("File error",stderr); exit (1);}  
  if(verboseLevel >= 2)
    cout<<" ---> File to convert : "<<fileN<<endl;
  // obtain file size:
  fseek (pFile , 0 , SEEK_END);
  totFileSizeByte = ftell (pFile);
  rewind (pFile);
  //cout<<"totFileSizeByte = "<<totFileSizeByte<<endl;
  // allocate memory to contain the whole file:
  buffer = (char*) malloc (sizeof(char)*totFileSizeByte);
  if (buffer == NULL) {fputs ("Memory error",stderr); exit (2);}
  // copy the file into the buffer:
  //result = fread (buffer,1,lSize,pFile);
  currentPositionByte = 0;
  fread (buffer,1,headerSize,pFile);
  currentPositionByte = currentPositionByte + headerSize;
  if(verboseLevel >= 2){
    for(j = 0;j<headerSize;j++){
      cout<<std::dec<<j<<" "<<buffer[j] << '\n';
      cout<<std::dec;
    }
  }
  buffTmp = buffer[headerSize-3];
  if( buffTmp != "="){
    cout<<" ERROR --> Wrong format"<<endl
	<<"         : buffer[headerSize-3] != ="<<endl;
    cout<<std::hex<<(int)buffer[headerSize-3] << '\n';
    cout<<std::dec;
    //cout<<10<< '\n';
    assert(0);
  } 
  while(currentPositionByte<totFileSizeByte){
    //for(j = 0;j<100;j++){
    currentPositionByte += fread (&EventNumber,1,4,pFile);
    currentPositionByte += fread (&EpochTime,1,8,pFile);
    currentPositionByte += fread (&Year,1,4,pFile);
    currentPositionByte += fread (&Month,1,4,pFile);
    currentPositionByte += fread (&Day,1,4,pFile);
    currentPositionByte += fread (&Hour,1,4,pFile);
    currentPositionByte += fread (&Minute,1,4,pFile);
    currentPositionByte += fread (&Second,1,4,pFile);
    currentPositionByte += fread (&Millisecond,1,4,pFile);
    currentPositionByte += fread (&TDCint64,1,8,pFile);
    EventNumber_usbwc = EventNumber;
    EpochTime_usbwc = EpochTime;
    Year_usbwc = Year;
    Month_usbwc = Month;
    Day_usbwc = Day;
    Hour_usbwc = Hour;
    Minute_usbwc = Minute;
    Second_usbwc = Second;
    Millisecond_usbwc = Millisecond;
    eventID = EventNumber_usbwc;
    UnixTime = EpochTime_usbwc;
    TDCint64usbwc = TDCint64;
    if(verboseLevel >= 2){
      cout<<"EventNumber_usbwc "<<EventNumber_usbwc<<endl
	  <<"EpochTime_usbwc   "<<EpochTime_usbwc<<endl
	  <<"Year_usbwc        "<<Year_usbwc<<endl
	  <<"Month_usbwc       "<<Month_usbwc<<endl
	  <<"Day_usbwc         "<<Day_usbwc<<endl
	  <<"Hour_usbwc        "<<Hour_usbwc<<endl
	  <<"Minute_usbwc      "<<Minute_usbwc<<endl
	  <<"Second_usbwc      "<<Second_usbwc<<endl
	  <<"Millisecond_usbwc "<<Millisecond_usbwc<<endl
	  <<"eventID           "<<eventID<<endl
	  <<"UnixTime          "<<UnixTime<<endl
	  <<"TDCint64          "<<TDCint64<<endl;
    }
    //assert(0);
    for(i = 0;i<nCh;i++){
      currentPositionByte += fread (&channel,1,4,pFile);
      currentPositionByte += fread (&EventIDsamIndexV,1,4,pFile);
      EventIDsamIndex[i] = EventIDsamIndexV;
      currentPositionByte += fread (&floatR,1,4,pFile); MeasuredBaselineV[i] = floatR;
      currentPositionByte += fread (&floatR,1,4,pFile); AmplitudeValue[i] = floatR;
      currentPositionByte += fread (&floatR,1,4,pFile); ComputedCharge[i] = floatR;
      currentPositionByte += fread (&floatR,1,4,pFile); RiseTimeInstant[i] = floatR;
      currentPositionByte += fread (&floatR,1,4,pFile); FallTimeInstant[i] = floatR;
      currentPositionByte += fread (&floatR,1,4,pFile); RawTriggerRate[i] = floatR;
      //EventIDsamIndex_usbwc = EventIDsamIndex;
      MeasuredBaseline_usbwc[i] = MeasuredBaselineV[i];
      AmplitudeValue_usbwc[i]   = AmplitudeValue[i];
      ComputedCharge_usbwc[i]   = ComputedCharge[i];
      RiseTimeInstant_usbwc[i]  = RiseTimeInstant[i];
      FallTimeInstant_usbwc[i]  = FallTimeInstant[i];
      RawTriggerRate_usbwc[i]   = RawTriggerRate[i];
      MeasuredBaseline[i] = MeasuredBaselineV[i];
      Amplitude[i]   = AmplitudeValue[i];
      Charge[i]   = ComputedCharge[i];
      LeadingEdgeTime[i]  = RiseTimeInstant[i];
      TrailingEdgeTime[i]  = FallTimeInstant[i];
      RateCounter[i]   = RawTriggerRate[i];
      //cout<<"Channel    "<<channel<<endl;
      //cout<<"EventIDsamIndex    "<<EventIDsamIndex<<endl;
    }
    //cout<<"EventNumber         "<<EventNumber<<endl;
    //cout<<"totFileSizeByte     "<<totFileSizeByte<<endl
    //<<"currentPositionByte "<<currentPositionByte<<endl;
    //for(i = 0;i<nCh;i++){
    //cout<<"MeasuredBaseline[i] "<<MeasuredBaseline[i]<<endl;
    //cout<<"AmplitudeValue[i]   "<<AmplitudeValue[i]<<endl;
    //}
    //printf ("EpochTime %13.0f \n", EpochTime);
    //cout<<"TDCint64 "<<TDCint64<<endl;
    //cout<<"Year         "<<Year<<endl
    //  <<"Month        "<<Month<<endl
    //  <<"Day          "<<Day<<endl
    //  <<"Hour         "<<Hour<<endl
    //  <<"Minute       "<<Minute<<endl
    //  <<"Second       "<<Second<<endl
    //  <<"Millisecond  "<<Millisecond<<endl;
    //assert(0);
    tree->Fill();
  } 
  // terminate
  fclose (pFile);
  free (buffer);
  hfile = tree->GetCurrentFile();
  hfile->Write();
  hfile->Close();
}
