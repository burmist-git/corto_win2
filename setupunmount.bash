#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Mon Aug 21 17:37:56 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script unmount all the connections to       #
#                     pc-serdi6.lal.in2p3.fr.                          #
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

symbl=$CORTOWINHOME"/"$CORTOWINLOG"/""/screenlog.0"
if [ -L $symbl ]; 
then
    unlink $symbl    
fi

symbl=$CORTOWINHOME"/"$CORTOWININFO"/"$CORTOWININFOPCSERDI6
if [ -L $symbl ]; 
then
    unlink $symbl    
fi

symbl=$CORTOWINHOME"/"$CORTOWINDATAPCBACKUP
if [ -L $symbl ]; 
then
    unlink $symbl    
fi

symbl0=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[0]}
if [ -L $symbl0 ]; 
then
    unlink $symbl0
fi
symbl1=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[1]}
if [ -L $symbl1 ]; 
then
    unlink $symbl1
fi
symbl2=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[2]}
if [ -L $symbl2 ]; 
then
    unlink $symbl2
fi
symbl3=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[3]}
if [ -L $symbl3 ]; 
then
    unlink $symbl3
fi

source umount-PC-SERDI6-windows.bash
