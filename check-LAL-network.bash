#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Wed Aug 30 10:04:06 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script check if LAL network is up.          #
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

check-LAL-network () {

    pcname=$CORTOWINPCLX2
    
    nobj=$(timeout 5s ping -c 3 $pcname | grep ttl | wc -l)

    #echo "nobj = $nobj"
    
    if [ "$nobj" -eq 3 ]
    then
	#echo "$pcname -> is in the LAN"
	echo 1;
	return 1;
    else
	#echo " ---> ERROR : $pcname -> is not in the LAN"
	#echo "Please switch on the PC and verify Ethernet connection in LAL network"
	#echo "Please unmount $pcname to avoid error due to the empty mounted point on this PC."
	#echo "For this please run ./umount-PC-SERDI6-windows.bash"
	echo 0;	
	return 0;
    fi

    return 0;

}

check-LAL-network

