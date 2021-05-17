//////////////////////////////////////////////////////////////////////////
//                                                                      //
// Copyright(C) 2017 - CORTO Collaboration                              //
// Sun Sep  3 18:04:30 CEST 2017                                        //
// Autor: Leonid Burmistrov                                             //
//                                                                      //
// File description:                                                    //
//                   This program update status file (dataanastatus)    //
//                   of the data analysis from CORTO.                   //
//                                                                      //
// Input paramete:                                                      //
//                   Compile and run without parameters for help.       //
//                                                                      //
// This software is provided "as is" without any warranty.              //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

//root
#include <TString.h>
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

void dataanastatus(TString statusParName, Int_t statusID);
void readDataAnaStatus(TString fileFullPath);
void writeDataAnaStatus(TString fileFullPath, TString statusParName, Int_t statusID);
void writeRunningDataAnaStatus();
TString getDataAnaStatusFilePath(bool printYes);
void readStatusProcessName();
void writeInitialDataAnaStatus();
Int_t statusStateStrToIntConv(TString statusStateStr);
TString statusStateIntToStrConv(Int_t statusStateInt);
void dumpDataAnaStatus();
void dumpDataAnaStatus(TString statusStateStr);

const Int_t nStatPr = 5;
TString statusProcessName[nStatPr];
Int_t statusState[nStatPr];

int verboseLevel = 0;

int main(int argc, char *argv[] ){
  if(argc == 4 && atoi(argv[1]) == 0){
    TString statusParName = argv[2];
    Int_t statusID = atoi(argv[3]);
    if(verboseLevel >= 1){
      cout<<endl
	  <<" statusParName : "<<statusParName<<endl
	  <<" statusID      : "<<statusID<<endl<<endl;
    }
    dataanastatus(statusParName, statusID);
  }
  else if(argc == 2 && atoi(argv[1]) == 1){
    writeInitialDataAnaStatus();
  }
  else if(argc == 2 && atoi(argv[1]) == 2){
    writeRunningDataAnaStatus();
  }
  else if(argc == 2 && atoi(argv[1]) == 3){
    dumpDataAnaStatus();
  }
  else if(argc == 3 && atoi(argv[1]) == 4){
    TString statusStateStr = argv[2];
    dumpDataAnaStatus(statusStateStr);
  }
  else{
    cout<<endl
	<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl
    	<<" <b> ---> ERROR in input arguments </b>"<<endl;
    cout<<" <b> -------------------------------- </b>"<<endl
    	<<"          <b> Normal opereation </b>"<<endl
    	<<"          <b> [1] : 0 </b>"<<endl
    	<<"          <b> [2] : Status parameter name </b>"<<endl
    	<<"          <b> [3] : Status ID (0 - False; 1 - True;) </b>"<<endl;
    cout<<" <b> -------------------------------- </b>"<<endl
	<<"          <b> Generation of initial data ana status file </b>"<<endl
    	<<"          <b> [1] : 1 </b>"<<endl;
    cout<<" <b> -------------------------------- </b>"<<endl
	<<"          <b> Generation of running data ana status file </b>"<<endl
    	<<"          <b> [1] : 2 </b>"<<endl;
    cout<<" <b> -------------------------------- </b>"<<endl
	<<"          <b> Dump data ana status file </b>"<<endl
    	<<"          <b> [1] : 3 </b>"<<endl;
    cout<<" <b> -------------------------------- </b>"<<endl
	<<"          <b> Dump data ana status file </b>"<<endl
    	<<"          <b> [1] : 4 </b>"<<endl
    	<<"          <b> [2] : Status parameter name </b>"<<endl;
  }
  return 0;
}

TString getDataAnaStatusFilePath(bool printYes=true){
  //-----------------------------------
  char* pPathchar = getenv ("CORTOWINHOME");
  TString fileFullPath = pPathchar;
  if(fileFullPath == ""){
    cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
    cout<<" <b> ---> ERROR CORTOWINHOME is not defined </b>"<<endl;
    cout<<"    <b> please define environment variables ( . setupCORTOWINworkspace.bash ) </b>"<<endl;
    assert(0);
  }
  char* anachar;
  anachar = getenv ("CORTOWINANA");
  fileFullPath += anachar;
  fileFullPath += "/";
  char* pNamechar = getenv ("CORTOWINSTATUSFILE");
  TString pName = pNamechar;
  fileFullPath += pName;
  //-------------------------------------
  if(printYes)
    cout<<" ---> dataanastatus : "<<fileFullPath<<" "<<endl;
  return fileFullPath;
}

void dataanastatus(TString statusParName, Int_t statusID){
  TString fileFullPath = getDataAnaStatusFilePath();
  readStatusProcessName();
  readDataAnaStatus(fileFullPath);
  writeDataAnaStatus(fileFullPath, statusParName, statusID);
}

void readDataAnaStatus(TString fileFullPath){
  string motName;
  string motStat;
  ifstream myfile(fileFullPath.Data());
  if (myfile.is_open()){
    for(int i = 0; i<nStatPr; i++){
      myfile>>motName>>motStat;
      //cout<<motName<<" "<<motStat<<endl;
      if(motName != statusProcessName[i]){
	cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
	cout<<" <b> ---> ERROR file motName != statusProcessName[i] </b>"<<endl;
	cout<<" <b>                 motName  = "<<motName<<" </b>"<<endl;
	cout<<" <b>                 statusProcessName[i] = "<<statusProcessName[i]<<" </b>"<<endl;
	assert(0);
      }
      statusState[i] = statusStateStrToIntConv(motStat);
      //cout<<statusState[i]<<endl;
    }
    myfile.close();
  }
  else{
    cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
    cout<<" <b> ---> ERROR file : "<<fileFullPath<<" is not open </b>"<<endl;
    assert(0);
  }
}

void readStatusProcessName(){
  statusProcessName[0] = getenv ("CORTOWINRUNISSTARTED");
  statusProcessName[1] = getenv ("CORTOWINRUNISOVER");
  statusProcessName[2] = getenv ("CORTOWINSYNCISOVER");
  statusProcessName[3] = getenv ("CORTOWINCONVISOVER");
  statusProcessName[4] = getenv ("CORTOWINRECOISOVER");
};

Int_t statusStateStrToIntConv(TString statusStateStr){
  if(statusStateStr == "False"){
    return 0;
  }
  else if(statusStateStr == "True"){
    return 1;
  }
  else{
    cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
    cout<<" <b> ---> ERROR statusStateStr is unknown </b>"<<endl;
    cout<<" <b>                 statusStateStr = "<<statusStateStr<<" </b>"<<endl;
    assert(0);
  }
  return 0;
}

TString statusStateIntToStrConv(Int_t statusStateInt){
  if(statusStateInt == 0){
    return "False";
  }
  else if(statusStateInt == 1){
    return "True";
  }
  else{
    cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
    cout<<" <b> ---> ERROR statusStateInt is unknown </b>"<<endl;
    cout<<" <b>                 statusStateInt = "<<statusStateInt<<" </b>"<<endl;
    assert(0);
  }
  return "False";
}

void writeDataAnaStatus(TString fileFullPath, TString statusParName, Int_t statusID){
  Int_t i = 0;
  Int_t nKey = 0;
  for(i = 0; i<nStatPr; i++){
    if(statusParName == statusProcessName[i]){
      statusState[i] = statusID;
      nKey++;
    }
  }
  //cout<<"nKey = "<<nKey<<endl;
  if(nKey != 1){
    cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
    cout<<" <b> ---> ERROR nKey != 1 </b>"<<endl;
    cout<<" <b>            nKey = "<<nKey<<" </b>"<<endl;
    assert(0);
  }
  ofstream myfile (fileFullPath.Data());
  if(myfile.is_open()){
    for(i = 0; i<nStatPr; i++)
      myfile<<statusProcessName[i]<<" "<<statusStateIntToStrConv(statusState[i])<<endl;
  }
  else{
    cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
    cout<<" <b> ---> ERROR file : "<<fileFullPath<<" is not open </b>"<<endl;
    assert(0);
  }
  myfile.close();
}

void writeInitialDataAnaStatus(){
  TString fileFullPath = getDataAnaStatusFilePath();
  readStatusProcessName();
  ofstream myfile (fileFullPath.Data());
  if(myfile.is_open()){
    myfile<<statusProcessName[0]<<" "<<statusStateIntToStrConv(0)<<endl;
    for(Int_t i = 1; i<nStatPr; i++)
      myfile<<statusProcessName[i]<<" "<<statusStateIntToStrConv(1)<<endl;
    myfile.close();
  }
  else{
    cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
    cout<<" <b> ---> ERROR file : "<<fileFullPath<<" is not open </b>"<<endl;
    assert(0);
  }
}

void writeRunningDataAnaStatus(){
  TString fileFullPath = getDataAnaStatusFilePath();
  readStatusProcessName();
  ofstream myfile (fileFullPath.Data());
  if(myfile.is_open()){
    myfile<<statusProcessName[0]<<" "<<statusStateIntToStrConv(1)<<endl;
    for(Int_t i = 1; i<nStatPr; i++)
      myfile<<statusProcessName[i]<<" "<<statusStateIntToStrConv(0)<<endl;
    myfile.close();
  }
  else{
    cout<<" <b> ---> ERROR while executing ./tools/dataanastatus.cc </b>"<<endl;
    cout<<" <b> ---> ERROR file : "<<fileFullPath<<" is not open </b>"<<endl;
    assert(0);
  }
}

void dumpDataAnaStatus(){
  TString fileFullPath = getDataAnaStatusFilePath();
  readStatusProcessName();
  readDataAnaStatus(fileFullPath);
  for(Int_t i = 0; i<nStatPr; i++)
    cout<<statusProcessName[i]<<" "<<statusStateIntToStrConv(statusState[i])<<endl;
}

void dumpDataAnaStatus(TString statusStateStr){
  TString fileFullPath = getDataAnaStatusFilePath(false);
  readStatusProcessName();
  readDataAnaStatus(fileFullPath);
  for(Int_t i = 0; i<nStatPr; i++)
    if(statusStateStr == statusProcessName[i])
      cout<<statusStateIntToStrConv(statusState[i])<<endl;
}
