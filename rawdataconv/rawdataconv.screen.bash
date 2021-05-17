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

ANAFOLDER="/home/gred/corto_win2/ana"
cd $ANAFOLDER

source setupCORTOWINworkspace.bash >/dev/null


#. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash > /dev/null
. /home/gred/corto_win2/ana/currentRunName.bash
cd $CORTOWINHOMEDIR"/"$CORTOWINANA"/"


screen -S $CORTOWINSCREENNAMECONV -L -d -m "/home/gred/corto_win2/ana/rawdataconv/rawdataconv.bash"
