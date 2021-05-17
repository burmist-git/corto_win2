#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Tue Jul 18 13:30:28 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script converts data with measurements from #
#                     USB-WC.                                          #
#                                                                      #
# Input paramete:                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash
. /home/gred/corto_win2/ana/currentRunName.bash
source $ROOTSHPULLPATH

#CORTOWINRUNNAME=$CORTOWINCURRENTRUNNAME       # Run name with measurements
#CORTOWINRUNNAMEWF=$CORTOWINCURRENTRUNNAMEWF   # Run name with WF
runname="Run_0001_06.09.2017.17.55.09"
runnamewf="Run_0001_06.09.2017.17.55.09_ToBeChanged"

#outlog=$CORTOWINHOME"/"$CORTOWINLOG"/"
#mkdir -p $outlog
#outlogFull=$outlog"/"$CORTOWINTRK$CORTOWINLOGSUFF

#rm -f $CORTOWINHOME"/"$CORTOWINANA"/"$CORTOWINTRK"/screenlog.0"
#rm -f $outlog"/"$CORTOWINTRK$CORTOWINSCREENLOGSUFF
#ln -s $CORTOWINHOME"/"$CORTOWINANA"/"$CORTOWINTRK"/screenlog.0" $outlog"/"$CORTOWINTRK$CORTOWINSCREENLOGSUFF

#source runmrpcDQH.bash $CORTOWINRUNNAME $CORTOWINRUNNAMEWF | tee -a $outlogFull
#source runtrkrecoDQH.bash $CORTOWINRUNNAME $CORTOWINRUNNAMEWF | tee -a $outlogFull
