#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Sep  1 11:30:07 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script makes symbolic link to the           #
#                     screenlog.0 (log of screen).                     #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

outlog=$CORTOWINHOME"/"$CORTOWINLOG"/"
mkdir -p $outlog
symbl=$outlog"/screenlog.0"

if [ ! -L $symbl ]; 
then
    ln -s $CORTOWINHOME"/"$CORTOWINANA"/screenlog.0" $symbl
    echo " ---> $symbl"
else
    unlink $symbl
    ln -s $CORTOWINHOME"/"$CORTOWINANA"/screenlog.0" $symbl    
fi
