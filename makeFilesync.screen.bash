#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Aug 18 12:10:16 CEST 2017                                        #
# Autor: Leonid Burmistrov, Vsevolod Yeroshenko                        #
#                                                                      #
# Script description:                                                  #
#                     This script perform data synchronization between #
#                     PC-SERDI6-win (with CORTO USB-WC) and PC-CORTO2  #
#                     for treatment of the data. This script executed  #
#                     with screen.                                     #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

#. defEnvCortoWin.bash

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash > /dev/null
. /home/gred/corto_win2/ana/currentRunName.bash
cd $CORTOWINHOMEDIR"/"$CORTOWINANA"/"

check_if_screen_isRunning.bash $CORTOWINSCREENNAMESYNC

checkStatus=$(echo $?)
#echo "checkStatus = $checkStatus" 

if [ "$checkStatus" -eq 1 ]
then
    echo ""
    echo ""
    echo ""
    echo "----------------------------------------------------" 
    echo " --> File synchronisation is already running        " 
    for i in "${CORTOWINUSBWCCARTEIDarr[@]}"
    do
        echo " --> For more tatails please execute this command : tail -f $CORTOWINHOME$CORTOWINLOG/${CORTOWINUSBWCCARTEIDarr[$i]}."
    done
    echo " --> Or attach the screen with this name : $CORTOWINSCREENNAMESYNC (> screen -r $CORTOWINSCREENNAMESYNC)"
    echo " checkStatus = $checkStatus                         " 
    echo "----------------------------------------------------" 
    exit 0
fi

check_if_screen_isRunning.bash $CORTOWINSCREENNAMECONV

checkStatus=$(echo $?)

if [ "$checkStatus" -eq 1 ]
then
    echo ""
    echo ""
    echo ""
    echo "----------------------------------------------------" 
    echo " --> Script for USB-WC raw data file conversion is  "
    echo "     already runningFile                            " 
    echo " --> For more details please attach the screen with " 
    echo "      this name : $CORTOWINSCREENNAMECONV     "
    echo "      (> screen -r $CORTOWINSCREENNAMECONV)   "
    echo "----------------------------------------------------" 
    exit 0
fi

/home/gred/corto_win2/ana/check-PC-SERDI6-ismount.bash

checkStatus=$(echo $?)
echo "checkStatus = $checkStatus" 

if [ "$checkStatus" -eq 0 ]
then
    echo ""
    echo ""
    echo "----------------------------------------------------" 
    echo " ERROR --> Impossible to make file synchronization  " 
    echo " Please use mount-PC-SERDI6-windows.bash script     "
    echo " to mount PC-SERDI6 in $CORTOWINPCSERDI6MPL  "
    echo " checkStatus = $checkStatus                         " 
    echo "----------------------------------------------------" 
    exit 0
fi

echo " --> File synchronization is in process !!! "

#echo " --> For more tatails please execute this command : tail -f $CORTOWINFILESYNCLOG"
#echo " --> For more tatails please execute this command : tail -f $CORTOWINFILESYNCLOG$CORTOWINDATAMRPCTOP"
#echo " --> For more tatails please execute this command : tail -f $CORTOWINFILESYNCLOG$CORTOWINDATAMRPCMID"
#echo " --> For more tatails please execute this command : tail -f $CORTOWINFILESYNCLOG$CORTOWINDATAMRPCBOT"
#echo " --> For more tatails please execute this command : tail -f $CORTOWINFILESYNCLOG$CORTOWINDATAUSE"
#echo " --> Or attach the screen with this name : $CORTOWINFILESYNCSCREENNAME (> screen -r $CORTOWINFILESYNCSCREENNAME)"

screen -S $CORTOWINSCREENNAMESYNC -L -d -m ./makeFilesync.bash
