#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Wed Jul 19 11:33:43 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                                                                      # 
#                                                                      #
# Input paramete: NON for the moment.                                  #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash
. /home/gred/corto_win2/ana/currentRunName.bash

echo " ---> BEGIN runtrkreco.bash <--- "
echo ""
date
echo ""

filename="Run_0005_Measurements_Only_9_11_2017.bin.root"

runtrkreco 0 $CORTOWINHOME"/"$CORTOWINDATAROOTL1"/"$CORTOWINCURRENTRUNNAME"/"${CORTOWINUSBWCMAParr[0]}"/"$filename $CORTOWINHOME"/"$CORTOWINDATAROOTL1"/"$CORTOWINCURRENTRUNNAME"/"${CORTOWINUSBWCMAParr[1]}"/"$filename $CORTOWINHOME"/"$CORTOWINDATAROOTL1"/"$CORTOWINCURRENTRUNNAME"/"${CORTOWINUSBWCMAParr[2]}"/"$filename ${CORTOWINMRPCCALIBarr[0]} ${CORTOWINMRPCCALIBarr[1]} ${CORTOWINMRPCCALIBarr[2]} 

CORTOWINHOME CORTOWINDATAROOTL2 CORTOWINCURRENTRUNNAME filename"_L2.root"

echo ""
date
echo ""
echo " ---> END runtrkreco.bash <--- "
