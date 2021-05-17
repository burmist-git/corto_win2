#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Wed Aug 30 10:19:34 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script clean (make clean) all executables   #
#                     for CORTO data treatment.                        #
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

makec () {
    make clean;
}

makec
