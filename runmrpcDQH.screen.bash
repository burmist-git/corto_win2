#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Sun Sep 10 03:23:59 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script executre runmrpcDQH.bash script in   # 
#                     screen.                                          #                    
#                                                                      #
# Input paramete:                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

source /home/gred/root_v5.34.34/root_v5.34.34-install/bin/thisroot.sh
. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash > /dev/null
. /home/gred/corto_win2/ana/currentRunName.bash
cd $CORTOWINHOMEDIR"/"$CORTOWINANA"/"

runmrpcDQHscreen () {    
    screen -S $CORTOWINSCREENNAMEDQP -L -d -m "./runmrpcDQH.bash"
    return 1
}

check_if_screen_isRunning.bash $CORTOWINSCREENNAMEDQP

checkStatus=$(echo $?)
#echo "checkStatus = $checkStatus" 

if [ "$checkStatus" -eq 1 ]
then
    echo ""
    echo "----------------------------------------------------" 
    echo " --> runmrpcDQH screen is already running        " 
    echo " --> To attach the screen with this name : $CORTOWINSCREENNAMEDQP (> screen -r $CORTOWINSCREENNAMEDQP)"
    echo " checkStatus = $checkStatus                         " 
    echo "----------------------------------------------------" 
    echo ""
    return 0
else
    runmrpcDQHscreen
    return 1
fi



