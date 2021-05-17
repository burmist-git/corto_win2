#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Mon Sep  4 19:17:13 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script check if USB-WC program in           #
#                     Corto_Crate1, Corto_Crate2, Corto_Crate3 and     #
#                     Corto_Crate4 connected to its expected USB-WC :  #
#                     | TOP -> TOP MRPC      |     Corto_Crate1     |  #
#                     | MID -> MIDDLE MRPC   |     Corto_Crate3     |  #
#                     | BOT -> BOTTOM MRPC   |     Corto_Crate2     |  #
#                     | USE -> USER channels |     Corto_Crate4     |  #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

ANAFOLDER="/home/gred/corto_win2/ana"
cd $ANAFOLDER
source setupCORTOWINworkspace.bash >/dev/null
. currentRunName.bash

verboseLevel=0

check-USB-WC-whenIsRunning () {
    . currentRunName.bash
    echo " <b> INFO: ---> Current run name $CORTOWINCURRENTRUNNAME </b>"
    #dataanastatus 3
    runStatus=`dataanastatus 4 RUNISSTARTED`
    if [ "$runStatus" = "False" ]
    then
        echo " <b> ERROR ---> Please start new run </b>"
	return 0
    fi
    . countWCfiles.bash
    ./discStorageMonitor.bash
    #echo "./check-USB-WC-whenIsRunning.bash"
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    # check-USB-WC-allAreConnected
    for i in `seq 0 $nn`;
    do
        if [ $i -le 2 ] # 1.1, 1.2, 1.3
        then
	    check-USB-WC-allAreConnected $i
	    checkStatus=$(echo $?)
	    #echo $checkStatus
	    if [ "$checkStatus" -eq 0 ]
	    then
		return 0
	    fi
        else  # 1.7
	    check-USB-WC-allAreConnected $i
	    checkStatus=$(echo $?)
	    if [ "$checkStatus" -eq 0 ]
	    then
		return 0
	    fi
        fi
    done
    # check-USB-WC-allAreRunning
    for i in `seq 0 $nn`;
    do
        if [ $i -le 2 ] # 1.1, 1.2, 1.3
        then
	    check-USB-WC-allAreRunning $i
	    checkStatus=$(echo $?)
	    if [ "$checkStatus" -eq 0 ]
	    then
		return 0
	    fi
        else  # 1.7
	    check-USB-WC-allAreRunning $i
	    checkStatus=$(echo $?)
	    if [ "$checkStatus" -eq 0 ]
	    then
		return 0
	    fi
        fi
    done
    # check-USB-WC-CarteIDisgood
    for i in `seq 0 $nn`;
    do
        if [ $i -le 2 ] # 1.1, 1.2, 1.3
        then
	    check-USB-WC-CarteIDisgood $i
	    checkStatus=$(echo $?)
	    if [ "$checkStatus" -eq 0 ]
	    then
		return 0
	    fi
        else  # 1.7
	    check-USB-WC-CarteIDisgood $i
	    checkStatus=$(echo $?)
	    if [ "$checkStatus" -eq 0 ]
	    then
		return 0
	    fi
        fi
    done
    #check-USB-WC-runIsOver
    check-USB-WC-runIsOver 0
    checkStatus=$(echo $?)
    if [ "$checkStatus" -eq 1 ]
    then
	check-USB-WC-runIsOver 1
	checkStatus=$(echo $?)
	if [ "$checkStatus" -eq 1 ]
	then
	    check-USB-WC-runIsOver 2
	    checkStatus=$(echo $?)
	    if [ "$checkStatus" -eq 1 ]
	    then
		check-USB-WC-runIsOver 3
		checkStatus=$(echo $?)
		if [ "$checkStatus" -eq 1 ]
		then
		    dataanastatus 0 RUNISOVER 1	    
		    return 1
		fi
	    fi
	fi
    fi
    #dataanastatus 3    
    return 1
    #echo "1"
}

check-USB-WC-allAreConnected () {
    logFile=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$1]}"/""logfile.txt"
    if [ ! -f $logFile ]; then
        echo " <b> ERROR ---> Please start USB-WC : ${CORTOWINUSBWCCARTEIDarr[$1]} </b>"
	if [ "$verboseLevel" -gt 0 ] 
	then
            echo " <b> ERROR ---> File $logFile doesnot exists. </b>"
            echo "          <b> Please start USB-WC program for : </b> "
            echo "                                       <b> ${CORTOWINUSBWCCARTEIDarr[$1]} </b>"
            echo "                                       <b> ${CORTOWINUSBWCMAParr[$1]} </b>"
            echo "                                       <b> ${CORTOWINUSBWCCARTEFOLDERarr[$1]} </b>"
            echo "                                       <b> i = $1 </b>"
	fi
        return 0;
    fi
    return 1;
}

check-USB-WC-allAreRunning () {
    logFile=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$1]}"/""logfile.txt"
    #INFO:19h:57min:38s: Run started with 10000000 events required.   
    wcn=`grep Run $logFile | grep started | grep with | grep events | grep required. | wc -l`
    if [ "$wcn" -lt 1 ] 
    then
        echo " <b> ERROR ---> USB-WC is not is not requiring data </b>"
        echo "          <b> Please start USB-WC require data for : </b> "
        echo "                                       <b> ${CORTOWINUSBWCCARTEIDarr[$1]} </b>"
        echo "                                       <b> ${CORTOWINUSBWCMAParr[$1]} </b>"
        echo "                                       <b> ${CORTOWINUSBWCCARTEFOLDERarr[$1]} </b>"
        echo "                                       <b> i = $1 </b>"
        return 0;
    fi
    #echo "1"
    return 1;
}

check-USB-WC-CarteIDisgood () {
    #18h:37min:58s: Board Serial Number: 1.2.
    #19h:48min:24s: Board Serial Number: 1.9.
    #19h:47min:54s: Board Serial Number: 1.3.
    #19h:48min:46s: Board Serial Number: 1.7.
    logFile=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$1]}"/""logfile.txt"
    #srn="$(grep Board $logFile | grep Serial | grep Number: | awk '{print $5}') | sed 's/\r$/ /'" 
    #srn="$(more $logFile | grep Board | grep Serial | grep Number: )" 
    srn=$(more $CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$1]}"/""logfile.txt" | grep Board | grep Serial | grep Number: | awk '{print $5}' | sed 's/\r//g' | rev | cut -c 2- | rev)
    if [ ${CORTOWINUSBWCCARTEIDarr[$1]} = $srn ] 
    then
	echo "<b> $srn  ${CORTOWINUSBWCCARTEIDarr[$1]}  ${CORTOWINUSBWCMAParr[$1]} ---> OK </b>"
        return 1;
    else
	echo "<b> $srn  ${CORTOWINUSBWCCARTEIDarr[$1]}  ${CORTOWINUSBWCMAParr[$1]} ---> ERROR </b>"
        return 0;
    fi
    return 0;
}

check-USB-WC-runIsOver () {
    #:20h:5min:6s: Run stopped.
    #INFO:20h:5min:7s: Data saved in file 'c:\Program Files (x86)\WaveCatcher_64ch\Corto_Crate2\Run_Data\Run_0001_04.09.2017.16.37.45\Run_0001_Measurements_Only_9_4_2017.bin' successfully.
    #INFO:20h:5min:7s: Run is over.
    logFile=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$1]}"/""logfile.txt"
    #wcRisS=`grep Run $logFile | grep stopped. | wc -l`
    wcRisO=`grep Run $logFile | grep is | grep over | wc -l`
    if [ "$wcRisO" -eq 1 ] 
    then
        echo " <b> ${CORTOWINUSBWCCARTEIDarr[$1]} ${CORTOWINUSBWCMAParr[$1]} ---> Run is over </b>"
        return 1;
    fi
    if [ "$wcRisO" -eq 0 ] 
    then
        #echo " <b> ${CORTOWINUSBWCCARTEIDarr[$1]} ${CORTOWINUSBWCMAParr[$1]} ---> Run is NOT over </b>"
	return 0;
    fi
    echo " <b> ERROR ---> is in check-USB-WC-status.bash check-USB-WC-runIsOver () </b>"
    echo " <b> ERROR ---> Multiple run is over in log file : </b>"
    echo "                                       <b> $logFile : </b> "
    echo "                                       <b> ${CORTOWINUSBWCCARTEIDarr[$1]} </b>"
    echo "                                       <b> ${CORTOWINUSBWCMAParr[$1]} </b>"
    echo "                                       <b> ${CORTOWINUSBWCCARTEFOLDERarr[$1]} </b>"
    echo "                                       <b> i = $1 </b>"
    return 0;
}

nPar=$#

if [ "$nPar" -eq 2 ]
then

    if [ "$1" == "check-USB-WC-runIsOver" ]
    then
	#echo "check-USB-WC-runIsOver"
	check-USB-WC-runIsOver $2
    fi
    
else

    check-USB-WC-whenIsRunning 

fi
