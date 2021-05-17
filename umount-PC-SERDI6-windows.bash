#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Sat Oct  8 18:15:12 CEST 2016                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script unmouts pc-serdi6.lal.in2p3.fr with  #
#                     raw USB-WC data from CORTO (hodoscope and user   #
#                     information) from this PC (PC-CORTO2).           #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

sudo umount -f $CORTOWINPCSERDI6MPC
sudo umount -f $CORTOWINPCSERDI6MPL
