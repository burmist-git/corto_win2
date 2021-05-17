#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Mon Sep  4 16:14:28 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script creates new run.                     #
#                                                                      #
# Input paramete:                                                      #
#                 RUNID                                                #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupLocale.bash

createNewRun () {

    #locale
    #LANG=en_US.UTF-8
    #LANGUAGE=en_US
    #LC_CTYPE="en_US.UTF-8"
    #LC_NUMERIC=fr_FR.UTF-8
    #LC_TIME=en_US.UTF-8
    #LC_COLLATE="en_US.UTF-8"
    #LC_MONETARY=fr_FR.UTF-8
    #LC_MESSAGES="en_US.UTF-8"
    #LC_PAPER=fr_FR.UTF-8
    #LC_NAME=fr_FR.UTF-8
    #LC_ADDRESS=fr_FR.UTF-8
    #LC_TELEPHONE=fr_FR.UTF-8
    #LC_MEASUREMENT=fr_FR.UTF-8
    #LC_IDENTIFICATION=fr_FR.UTF-8
    
    newRunID=$1
    
    ## date format ##
    NOWT=$(date +"%d.%m.%Y.%H.%M.%S")
    
    newRunName='Run_'"$newRunID"'_'$NOWT
    
    echo " ---> Create a new run : $newRunName"

    echo $newRunName > $CORTOWINHOME"/"$CORTOWINANA"/"$CORTOWINRUNNAMEFILE
 
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    for i in `seq 0 $nn`;
    do
        if [ $i -le 2 ] # 1.1, 1.2, 1.3
        then
	    echo "mkdir $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Run_Data/"$newRunName"
	    mkdir $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Run_Data/"$newRunName
        else  # 1.7
	    echo "mkdir $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Run_Data/"$newRunName"
	    mkdir $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Run_Data/"$newRunName
        fi
    done

    return 1;

}

returnZero () {
    
    return 0;
    
}

nPar=$#

if [ "$nPar" -eq 1 ]
then
    
    createNewRun $1
    
else
    echo " <b> ---> ERROR while executing ./createNewRun.bash </b>"
    echo " <b> ---> ERROR in input arguments : </b>"
    echo "                                [1] run ID "
    echo " <b> ---> Script description : </b>"
    echo " <b>                         This script creates new run. </b>"
    returnZero;
fi
