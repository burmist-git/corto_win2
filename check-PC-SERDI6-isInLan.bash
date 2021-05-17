#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Sat Oct  8 18:16:19 CEST 2016                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script check if PC-SERDI6 is in LAN.        #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################
ANAFOLDER="/home/gred/corto_win2/ana"

source $ANAFOLDER/setupCORTOWINworkspace.bash >/dev/null
cd $ANAFOLDER

check_PC_SERDI6_isInLan () {

    pcname=$CORTOWINPCSERDI6
    
    nobj=$(timeout 5s ping -c 3 $pcname | grep ttl | wc -l)

    #echo "nobj = $nobj"
    
    if [ "$nobj" -eq 3 ]
    then
	echo "$pcname -> is in the LAN"
	return 1;
    else
	echo " ---> ERROR : $pcname -> is not in the LAN"
	echo "Please switch on the PC and verify Ethernet connection in LAL network"
	echo "Please unmount $pcname to avoid error due to the empty mounted point on this PC."
	echo "For this please run ./umount-PC-SERDI6-windows.bash"
	return 0;
    fi

    return 0;

}

check_PC_SERDI6_isInLan
