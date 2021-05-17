#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Mon Sep 11 10:34:14 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script makes symbolic link to the folder    #
#                     with backup information from Corto Crates.       #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

mountBackup () {

    symbl=$CORTOWINHOME"/"$CORTOWINDATAPCBACKUP

    if [ ! -L $symbl ]; 
    then
	#echo "ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/${CORTOWINUSBWCCARTEFOLDERarr[$i]}/ $symbl"
	ln -s $CORTOWINARCHIVEFULLPATH $symbl
	echo " ---> $symbl"
    else
	unlink $symbl
	ln -s $CORTOWINARCHIVEFULLPATH $symbl
    fi

    return 1
}

mountBackup
