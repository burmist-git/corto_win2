#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Tue Jul 18 14:11:07 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script mouts pc-serdi6.lal.in2p3.fr with    #
#                     raw USB-WC data from CORTO (hodoscope and user   #
#                     information) to this PC (PC-CORTO2) for data     #
#                     treatment.                                       #
#                                                                      #
# Input paramete:                                                      #
#                 [1] 'C' -> mount C ; 'L' -> mount L                  #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

mkdir -p $CORTOWINPCSERDI6MPC
mkdir -p $CORTOWINPCSERDI6MPL

#  Sat Jul 22 18:59:27 CEST 2017

mount_PC_SERDI6_windowsC () {

    sudo mount -t cifs -o username=gred,password=V1jfvntl,uid=1001,gid=1001,rw,file_mode=0777,dir_mode=0777 //pc-serdi6.lal.in2p3.fr/C/ $CORTOWINPCSERDI6MPC -o vers=2.0
    
}

mount_PC_SERDI6_windowsL () {
    
    sudo mount -t cifs -o username=gred,password=V1jfvntl,uid=1001,gid=1001,rw,file_mode=0777,dir_mode=0777 //pc-serdi6.lal.in2p3.fr/L/ $CORTOWINPCSERDI6MPL -o vers=2.0

}

nPar=$#

if [ "$nPar" -eq 1 ]
then

    if [ $1 = 'C' ]
    then        
        mount_PC_SERDI6_windowsC
    elif [ $1 = 'L' ]
    then        
        mount_PC_SERDI6_windowsL
    else
        echo " ---> ERROR in input arguments : "
	echo "                                [1] C --> mount disk C or L --> check if disk L is mounted"
    fi

else
    
    echo " ---> ERROR in input arguments : "
    echo "                                [1] C --> mount disk C or L --> check if disk L is mounted"
    
fi
