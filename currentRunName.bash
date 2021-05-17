#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Tue Jul 18 14:11:07 CEST 2017                                        #
# Autor: Leonid Burmistrov, Vsevolod Yeroshenko                        #
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

ANAFOLDER="/home/gred/corto_win2/ana/"
cd $ANAFOLDER
. setupCORTOWINworkspace.bash > /dev/null

currentRunName(){
    runNameFile=$ANAFOLDER"/"$CORTOWINRUNNAMEFILE
    export CORTOWINCURRENTRUNNAME=`less $runNameFile`
    export CORTOWINCURRENTRUNNAMEWF=`less $runNameFile`"_ToBeChanged"
    return 0
}

currentRunName

#export CORTOWINCURRENTRUNNAME="Run_0012_10.02.2017.22.25.22"      # Run name with measurements
#export CORTOWINCURRENTRUNNAMEWF="Run_0012_Data_2_10_2017_Binary"  # Run name with WF
