#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Mon Sep 4 12:08:24 CEST 2017                                         #
# Autor: Leonid Burmistrov, Vsevolod Yeroshenko                        #
#                                                                      #
# Script description:                                                  #
#                     This script converts data with mesurements from  #
#                     USB-WC to .root format                           #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################
. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash > /dev/null
. /home/gred/corto_win2/ana/currentRunName.bash
source /home/gred/root_v5.34.34/root_v5.34.34-install/bin/thisroot.sh

cd $CORTOWINHOMEDIR"/"$CORTOWINANA"/"
 
makeFileconv() {
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    for i in `seq 0 $nn`;
    do 
	if [ $i -le 2 ]; # TOP MID BOT without USE
	then
	    inData=$CORTOWINHOME"/"$CORTOWINDATADATA"/"$CORTOWINCURRENTRUNNAME"/"${CORTOWINUSBWCMAParr[$i]}"/"
	    #echo 'inData '$inData
	    #outData=$CORTOWINROOTL1PATHFULL${CORTOWINUSBWCCARTEIDarr[$i]}"/"$CORTOWINRUNNAME"/"
	    outData=$CORTOWINHOME"/"$CORTOWINDATAROOTL1"/"$CORTOWINCURRENTRUNNAME"/"${CORTOWINUSBWCMAParr[$i]}"/"
	    if [ ! -d $outData ]; then
		mkdir -p $outData;
	    fi;
	    logPath=$CORTOWINHOME"/"$CORTOWINLOG"/"$CORTOWINCURRENTRUNNAME"/"
	    if [ ! -d "$logPath" ]; then
		mkdir -p $logPath;
	    fi 
	    if [ ! -f "$logPath/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log.prev" ]; then
		> $logPath/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log.prev
	    fi
	    for inDataFile in `diff $logPath/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log $logPath/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log.prev | grep Run | awk '{print $6}'`
	    do
      		#echo $inDataFile
		outDataFile=$inDataFile".root"
		echo $inData"/"$inDataFile
		echo $outData"/"$outDataFile
		cd - > /dev/null
		convertUSBWCMeas2root48ChannelsBinOneToOne 0 $inData"/"$inDataFile $outData"/"$outDataFile
		cd - > /dev/null
	    done
	    cd - > /dev/null
	    if [ `diff $logPath/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log $logPath/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log.prev | grep Run | awk '{print $6}'| wc -l` = "0" ]
	    then
		dataanastatus 0 $CORTOWINCONVISOVER 1
		dataanastatus 0 $CORTOWINRECOISOVER 1
		echo "There's no files to convert for ${CORTOWINUSBWCMAParr[$i]}!"
	    else 
		dataanastatus 0 $CORTOWINCONVISOVER 0
		dataanastatus 0 $CORTOWINRECOISOVER 0
	    fi
	    cp $logPath/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log $logPath/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log.prev
	    #########################
	else  # 1.7 <-> USE
	    #./convertUSBWCMeas2root48ChannelsBinOneToOne
	    echo "NON"
	fi;
	
    done
    
}

makeFileconv | tee -a $CORTOWINHOME"/"$CORTOWINLOG"/"$CORTOWINCURRENTRUNNAME"/"ConvFile.log
