#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Mon Sep 11 10:24:32 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script creates new run.                     #
#                                                                      #
# Input paramete:                                                      #
#                 RUNID                                                #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupLocale.bash

backupUSB-WCsetupFiles () {
    
    ## date format ##
    NOWT=$(date +"%d.%m.%Y.%H.%M.%S")
    
    backupSetup='backupSetup_'$NOWT
    backupSetupFull=$CORTOWINARCHIVEFULLPATH"/setup/"$backupSetup

    echo " ---> Backup USB-WC setup folder : $backupSetupFull"

    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    for i in `seq 0 $nn`;
    do
	cpwhat=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}"/Setup/*"
	cpwhere=$backupSetupFull"/"${CORTOWINUSBWCMAParr[$i]}	
	#echo "cpwhat = $cpwhat"
	#echo "cpwhere = $cpwhere"
	mkdir -p $cpwhere
	cp $cpwhat $cpwhere
    done
    
    return 1;

}

backupUSB-WCsetupFiles
