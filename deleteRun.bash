##!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Mon Sep  4 18:14:43 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script delete run.                          #
#                                                                      #
# Input paramete:                                                      #
#                 RUN name                                             #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

deleteRun () {
    
    newRunName=$1
    
    echo " ---> delete run : $newRunName"
 
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    for i in `seq 0 $nn`;
    do
        if [ $i -le 2 ] # 1.1, 1.2, 1.3
        then
	    echo "rm -rf $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Run_Data/"$newRunName"
	    rm -rf $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Run_Data/"$newRunName
        else  # 1.7
	    echo "rm -rf $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Run_Data/"$newRunName"
	    rm -rf $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Run_Data/"$newRunName
        fi
    done

    echo "rm -rf ../log/$newRunName"
    rm -rf "../log/$newRunName"
    echo "rm -rf ../data/$newRunName"
    rm -rf "../data/$newRunName"
    echo "rm -rf ../root_data_L1/$newRunName"
    rm -rf "../root_data_L1/$newRunName"
    echo "rm -rf ../dataQualityHisto/$newRunName"
    rm -rf ../dataQualityHisto/$newRunName
    echo "rm -rf ../dataQualityPlots/$newRunName"
    rm -rf ../dataQualityPlots/$newRunName


    return 1;

}

returnZero () {
    
    return 0;
    
}

nPar=$#

if [ "$nPar" -eq 1 ]
then
    
    deleteRun $1
    
else
    echo " <b> ---> ERROR while executing ./createNewRun.bash </b>"
    echo " <b> ---> ERROR in input arguments : </b>"
    echo "                                [1] run name "
    echo " <b> ---> Script description : </b>"
    echo " <b>                         This script creates new run. </b>"
    returnZero;
fi
