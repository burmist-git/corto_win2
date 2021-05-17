#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Sat Jul  8 14:29:30 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script set up constant parameters of CORTO  #
#                     and CORTO DAQ (USB-WC)                           #
#                     For normal operation this script should be       #
#                     executed like this: > . constCORTO.bash          #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

export CORTOWINMRPCNCH=48              # Number of channels per MRPC.
export CORTOWINMRPCNST=24              # Number of strips per MRPC.
export CORTOWINMRPCSIGTHRES=0.1        # Amplitude threshold of the signal from MRPC, V.
export CORTOWINMRPCSIGBASELINECUT=0.01 # Amplitude window of the baseline signal from MRPC, V.
echo ""
echo "|--------------------------> constCORTO.bash <--------------------------|"
echo "|CORTOWINMRPCNCH            = $CORTOWINMRPCNCH                                        |"
echo "|CORTOWINMRPCNST            = $CORTOWINMRPCNST                                        |"
echo "|CORTOWINMRPCSIGTHRES       = $CORTOWINMRPCSIGTHRES                                       |"
echo "|CORTOWINMRPCSIGBASELINECUT = $CORTOWINMRPCSIGBASELINECUT                                      |"
echo "|-----------------------------------------------------------------------|"
