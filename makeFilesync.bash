#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Wed Aug 30 19:27:19 CEST 2017                                        #
# Autor: Leonid Burmistrov, Vsevolod Yeroshenko                        #
#                                                                      #
# Script description:                                                  #
#                     This script perform data synchronization between #
#                     PC-SERDI6-win (with CORTO USB-WC) and PC-CORTO2  #
#                     for treatment of the data.                       #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash > /dev/null
. /home/gred/corto_win2/ana/currentRunName.bash
source /home/gred/root_v5.34.34/root_v5.34.34-install/bin/thisroot.sh

#. $ROOTSHFULLPATH
cd $CORTOWINHOMEDIR"/"$CORTOWINANA"/"

echo "CORTOWINCURRENTRUNNAME=$CORTOWINCURRENTRUNNAME"


makeFilesync(){
    array=( 0 1 2)
    syncstatus=0

    for i in "${array[@]}"
    do
	if [ ! -d "$CORTOWINHOME/$CORTOWINDATADATA/$CORTOWINCURRENTRUNNAME/${CORTOWINUSBWCMAParr[$i]}" ]
	then
	    mkdir -p $CORTOWINHOME/$CORTOWINDATADATA/$CORTOWINCURRENTRUNNAME/${CORTOWINUSBWCMAParr[$i]}
	fi
	if [ ! -d "$CORTOWINHOME/$CORTOWINLOG/$CORTOWINCURRENTRUNNAME" ]
	then
	    mkdir -p $CORTOWINHOME/$CORTOWINLOG/$CORTOWINCURRENTRUNNAME
	fi
	fileSyncLog[$i]=$CORTOWINHOME/$CORTOWINLOG/$CORTOWINCURRENTRUNNAME/${CORTOWINUSBWCCARTEIDarr[$i]}.LastSyncFile.log
	echo "rsync --log-file=$CORTOWINHOME/$CORTOWINLOG/$CORTOWINCURRENTRUNNAME/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log -a -v $CORTOWINHOME$CORTOWINDATAPCSERDI/${CORTOWINUSBWCMAParr[$i]}/Run_Data/$CORTOWINCURRENTRUNNAME/ $CORTOWINHOME$CORTOWINDATADATA/$CORTOWINCURRENTRUNNAME/${CORTOWINUSBWCMAParr[$i]}/ | tee ${fileSyncLog[$i]}"
	rsync --log-file="$CORTOWINHOME/$CORTOWINLOG/$CORTOWINCURRENTRUNNAME/${CORTOWINUSBWCCARTEIDarr[$i]}.FullSyncFile.log" -a -v $CORTOWINHOME/$CORTOWINDATAPCSERDI/${CORTOWINUSBWCMAParr[$i]}/Run_Data/$CORTOWINCURRENTRUNNAME/ $CORTOWINHOME$CORTOWINDATADATA/$CORTOWINCURRENTRUNNAME/${CORTOWINUSBWCMAParr[$i]}/ | tee "${fileSyncLog[$i]}"
	if [ `grep $CORTOWINCURRENTRUNNAME ${fileSyncLog[$i]} | grep bin | wc -l` = 0 ]
	then
	    dataanastatus 0 $CORTOWINSYNCISOVER 1
	else 
	    dataanastatus 0 $CORTOWINSYNCISOVER 0
	fi
    done
}


makeFilesync
