#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Tue Jul 18 14:11:07 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script define the names of current run.     #
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
#export CORTOWINCURRERNTRUNSTATUS="START"    # Current run status
export CORTOWINCURRERNTRUNSTATUS="RUNNING"   # Current run status
#export CORTOWINCURRERNTRUNSTATUS="STOP"     # Current run status
