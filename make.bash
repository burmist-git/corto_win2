#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Wed Aug 30 10:19:34 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script build (make) all executables for     #
#                     CORTO data treatment.                            #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

ANAFOLDER="/home/gred/corto_win2/ana"
cd $ANAFOLDER
source setupCORTOWINworkspace.bash >/dev/null


makee () {
    make;
}

makee
