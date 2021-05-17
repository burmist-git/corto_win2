#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Aug 18 15:01:57 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script makes symbolic link to the folder    #
#                     with information from Corto Crates.              #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

mkdir -p $CORTOWINHOME"/"$CORTOWINDATAPCSERDI

nn=${#CORTOWINUSBWCCARTEIDarr[@]}
let nn=nn-1
for i in `seq 0 $nn`;
do
    if [ $i -le 2 ] # 1.2, 1.9, 1.3 <-> TOP MID BOT - loop and links over the MRPC USB-WC cartes.
    then
	symbl=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}
	if [ ! -L $symbl ]; 
	then
	    #echo "ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/${CORTOWINUSBWCCARTEFOLDERarr[$i]}/ $symbl"
	    ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/${CORTOWINUSBWCCARTEFOLDERarr[$i]}/ $symbl
	    echo " ---> $symbl"
	else
	    unlink $symbl
	    ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/${CORTOWINUSBWCCARTEFOLDERarr[$i]}/ $symbl
	fi
    else  # 1.7 and links USB-WC for users.
	symbl=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$i]}
	if [ ! -L $symbl ]; 
	then
	    #echo "ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/${CORTOWINUSBWCCARTEFOLDERarr[$i]}/ $symbl"
	    ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/${CORTOWINUSBWCCARTEFOLDERarr[$i]}/ $symbl
	    echo " ---> $symbl"
	else
	    unlink $symbl
	    ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/${CORTOWINUSBWCCARTEFOLDERarr[$i]}/ $symbl
	fi
    fi
done
