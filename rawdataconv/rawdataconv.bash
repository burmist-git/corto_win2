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

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash > /dev/null
. /home/gred/corto_win2/ana/currentRunName.bash
cd $CORTOWINHOMEDIR"/"$CORTOWINANA"/"

source $ROOTSHPULLPATH

CORTOWINRUNNAME=$CORTOWINCURRENTRUNNAME         # Run name with measurements
CORTOWINRUNNAMEWF=$CORTOWINCURRENTRUNNAMEWF     # Run name with WF

outlog=$CORTOWINHOME"/"$CORTOWINLOG"/"
#mkdir -p $outlog
outlogFull=$outlog"/"$CORTOWINCONV$CORTOWINLOGSUFF

#rm -f $CORTOWINHOME"/"$CORTOWINANA"/"$CORTOWINCONV"/screenlog.0"
#rm -f $outlog"/"$CORTOWINCONV$CORTOWINSCREENLOGSUFF
#ln -s $CORTOWINHOME"/"$CORTOWINANA"/"$CORTOWINCONV"/screenlog.0" $outlog"/"$CORTOWINCONV$CORTOWINSCREENLOGSUFF

source /home/gred/corto_win2/ana/rawdataconv/convertUSBWCMeas2root48ChannelsBinOneToOne.bash $CORTOWINRUNNAME $CORTOWINRUNNAMEWF | tee -a $outlogFull
