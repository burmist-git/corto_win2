#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Thu Sep  7 22:13:00 CEST 2017                                        #
# Autor: Leonid Burmistrov, Vsevolod Yeroshenko                        #
#                                                                      #
# Script description:                                                  #
#                     This script perform monitor of disc storage      #
#                     space.                                           #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################


discStorageMonitor () {
    #echo "<table>"
    #echo "<tr> <td> pc-serdi6 C </td> <td> $(df -h | grep pc-serdi6 | grep win_C | awk '{print $4}') </td> </tr>"
    #echo "<tr> <td> pc-serdi6 L </td> <td> $(df -h | grep pc-serdi6 | grep win_L | awk '{print $4}') </td> </tr>"
    #echo "<tr> <td> pc-corto2 /home/gred/ </td> <td> $(df -h | grep gred | grep .Private | awk '{print $4}') </td> </tr>"
    #echo "</table>"
    echo "<table> <tr> <td> pc-serdi6 C </td> <td> $(df -h | grep pc-serdi6 | grep win_C | awk '{print $4}') </td> </tr> <tr> <td> pc-serdi6 L </td> <td> $(df -h | grep pc-serdi6 | grep win_L | awk '{print $4}') </td> </tr> <tr> <td> pc-corto2 /home/gred/ </td> <td> $(df -h | grep gred | grep .Private | awk '{print $4}') </td> </tr> </table>"
    return 1
}

discStorageMonitor
