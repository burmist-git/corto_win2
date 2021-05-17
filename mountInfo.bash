#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Aug 18 12:10:16 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script makes symbolic link to the folder    #
#                     with information about corto current status and  #
#                     setup.                                           #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

symbl=$CORTOWINHOME"/"$CORTOWININFO"/"$CORTOWININFOPCSERDI6

if [ ! -L $symbl ]; 
then
    ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/info/ $symbl
    echo " ---> $symbl"
else
    unlink $symbl
    ln -s $CORTOWINPCSERDI6MPC/Program\ Files\ \(x86\)/WaveCatcher_64ch/info/ $symbl    
fi
