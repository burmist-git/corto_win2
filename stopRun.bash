#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Wed Aug 30 10:19:34 CEST 2017                                        #
# Autor: Leonid Burmistrov, Vsevolod Yeroshenko                        #
#                                                                      #
# Script description:                                                  #
#                     This script end current run of the USB-WC data   #
#                     analysis.                                        #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

ANAFOLDER="/home/gred/corto_win2/ana"
cd $ANAFOLDER
. setupCORTOWINworkspace.bash >/dev/null
. currentRunName.bash

#echo "./stopRun.bash"

compareNumberOfFiles(){
    SyncFileNum=( 0, 0, 0, 0)
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    for i in `seq 0 $nn`; do
	SyncFileNum[$i]=`ls $CORTOWINHOME/$CORTOWINDATADATA/$CORTOWINCURRENTRUNNAME/${CORTOWINUSBWCMAParr[$i]} | wc -l`
	WrittenFileNum[$i]=`./countWCfiles.bash $i`
	echo "SyncFileNum = ${SyncFileNum[$i]}"
	echo "WrittenFileNum = ${WrittenFileNum[$i]}"
	if [ "${SyncFileNum[$i]}" != "${WrittenFileNum[$i]}" ]; then
	    echo "<b>ERROR ---> Number of written files for ${CORTOWINUSBWCMAParr[$i]} is not qual to number of synchronized data</b>"
	    return 0
	fi
	return 1
    done
}

stopRun(){
    syncStatus=`dataanastatus 4 $CORTOWINSYNCISOVER`
    convStatus=`dataanastatus 4 $CORTOWINCONVISOVER`
    recoStatus=`dataanastatus 4 $CORTOWINRECOISOVER`
    if [ $syncStatus = "True" ]; then
	if [ $convStatus = "True" ]; then
	    if [ $recoStatus = "True" ]; then
		compareNumberOfFiles
		compareStatus=$(echo $?)
		if [ $compareStatus -eq 1 ]; then
		    echo "<b>INFO ---> Run is stopped. Now you can start a new run.</b>"
		    cp $CORTOWINHOME"/"$CORTOWINANA"/"$CORTOWINSCREENLOGFILE $CORTOWINHOME"/"$CORTOWINLOG"/"$CORTOWINCURRENTRUNNAME"/".
		    dataanastatus 1
		    return 1
		fi
		return 0
	    fi
	    echo "<b>ERROR ---> Reconstruction is still in process. Please wait.</b>"
	    return 0
	fi
	echo "<b>ERROR ---> Conversion is still in process. Please wait.</b>"
	return 0
    fi
    echo "<b>ERROR ---> Synchronization is in process. Please wait. </b>"
    return 0
}

stopRun 
