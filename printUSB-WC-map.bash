#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Sep  8 10:27:43 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script print CORTO USB-WC map               #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

echo ""
echo "|---------------------------------------------------|"
echo "|                  USB-WC MAPPING                   |"
echo "|---------------------------------------------------|"
echo "| CORTOWINUSBWCCARTEIDarr = | ${CORTOWINUSBWCCARTEIDarr[0]} | ${CORTOWINUSBWCCARTEIDarr[1]} | ${CORTOWINUSBWCCARTEIDarr[2]} | ${CORTOWINUSBWCCARTEIDarr[3]} |"
echo "| CORTOWINUSBWCMAParr     = | ${CORTOWINUSBWCMAParr[0]} | ${CORTOWINUSBWCMAParr[1]} | ${CORTOWINUSBWCMAParr[2]} | ${CORTOWINUSBWCMAParr[3]} |"
echo "|---------------------------------------------------|"
echo "| ${CORTOWINUSBWCMAParr[0]} -> TOP MRPC      |        ${CORTOWINUSBWCCARTEFOLDERarr[0]}        |"
echo "| ${CORTOWINUSBWCMAParr[1]} -> MIDDLE MRPC   |        ${CORTOWINUSBWCCARTEFOLDERarr[1]}        |"
echo "| ${CORTOWINUSBWCMAParr[2]} -> BOTTOM MRPC   |        ${CORTOWINUSBWCCARTEFOLDERarr[2]}        |"
echo "| ${CORTOWINUSBWCMAParr[3]} -> USER channels |        ${CORTOWINUSBWCCARTEFOLDERarr[3]}        |"
echo "|---------------------------------------------------|"
echo ""
