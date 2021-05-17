#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Sat Jul 22 19:42:32 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script mouts pc-serdi6.lal.in2p3.fr and     #
#                     setup symbolic links.                            #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

#mkdir -p $CORTOWINHOME"/"$CORTOWININFO

ANAFOLDER="/home/gred/corto_win2/ana"

source $ANAFOLDER/setupCORTOWINworkspace.bash >/dev/null
cd $ANAFOLDER

./check-PC-SERDI6-isInLan.bash

checkStatus=$(echo $?)

#echo $checkStatus

if [ "$checkStatus" -eq 1 ]
then
    ./check-PC-SERDI6-ismount.bash C
    checkStatus=$(echo $?)
    #echo $checkStatus
    if [ "$checkStatus" -eq 0 ]
    then
	./mount-PC-SERDI6-windows.bash C
    fi

    ./check-PC-SERDI6-ismount.bash L
    checkStatus=$(echo $?)
    #echo $checkStatus
    if [ "$checkStatus" -eq 0 ]
    then
	./mount-PC-SERDI6-windows.bash L
    fi

    ./check-PC-SERDI6-ismount.bash C
    ./check-PC-SERDI6-ismount.bash L

    ./mountInfo.bash
    ./mountLog.bash

    source mountCortoCrates.bash

    source mountBackup.bash

else
    echo " NOT MOUNTED "
fi
