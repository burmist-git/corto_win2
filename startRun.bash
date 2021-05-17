#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Sat Sep  2 13:54:05 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script prepare new run of the USB-WC data   #
#                     taking and analysis.                             #
#                                                                      #
# Input paramete:                                                      #
#                 RUNID                                                #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash > /dev/null

startRun () {
    #rm -f ../datapc-serdi6/TOP/logfile.txt
    #rm -f ../datapc-serdi6/MID/logfile.txt
    #rm -f ../datapc-serdi6/BOT/logfile.txt
    #rm -f ../datapc-serdi6/USE/logfile.txt
    #Set to zero screen log file.
    echo "" > $CORTOWINHOME"/"$CORTOWINANA"/"$CORTOWINSCREENLOGFILE
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    for i in `seq 0 $nn`;
    do
        if [ $i -le 2 ] # 1.1, 1.2, 1.3
        then
	    logFile=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/""logfile.txt"
	    rm -f $logFile
	    if [ -f $logFile ]; then
		echo " <b> ERROR ---> File $logFile exists. </b>"
		echo "          <b> Please close USB-WC program for : </b> "
		echo "                                       <b> ${CORTOWINUSBWCCARTEIDarr[$i]} </b>"
		echo "                                       <b> ${CORTOWINUSBWCMAParr[$i]} </b>"
		echo "                                       <b> ${CORTOWINUSBWCCARTEFOLDERarr[$i]} </b>"
		echo "                                       <b> i = $i </b>"
		return 0;
	    fi
            #ls    $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/""logfile.txt"
        else  # 1.7
	    logFile=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/""logfile.txt"
            rm -f $logFile
	    if [ -f $logFile ]; then
		echo " <b> ---> ERROR qFile $logFile exists. </b>"
		echo "          <b> Please close USB-WC program for : </b> "
		echo "                                       <b> ${CORTOWINUSBWCCARTEIDarr[$i]} </b>"
		echo "                                       <b> ${CORTOWINUSBWCMAParr[$i]} </b>"
		echo "                                       <b> ${CORTOWINUSBWCCARTEFOLDERarr[$i]} </b>"
		echo "                                       <b> i = $i </b>"
		return 0;
	    fi
        fi
    done
    
    . createNewRun.bash $1

    checkStatus=$(echo $?)    
    #echo $checkStatus
    if [ "$checkStatus" -eq 1 ]
    then
	#echo "dataanastatus $CORTOWINRUNISSTARTED 1"
	#update status of dataana - dataanastatus file
	dataanastatus 0 $CORTOWINRUNISSTARTED 1
	dataanastatus 0 $CORTOWINRUNISOVER 0
	dataanastatus 0 $CORTOWINSYNCISOVER 0
	dataanastatus 0 $CORTOWINCONVISOVER 0
	dataanastatus 0 $CORTOWINRECOISOVER 0
    else
	return 0;
    fi
    echo " <b> ------------------------------------------------------------------- </b> "
    echo " <b> ---> Please start the wavecatcher <--- </b> "
    echo " <b> ------------------------------------------------------------------- </b> "    

    return 1;
}

nPar=$#

if [ "$nPar" -eq 1 ]
then
    
    #echo $1

    startRun $1
    
else
    echo " ---> ERROR in input arguments : "
    echo "                                [1] run ID"
    echo " ---> Script description :"
    echo "                           This script prepare new run of the USB-WC data"
    echo "                           taking and analysis."
fi
