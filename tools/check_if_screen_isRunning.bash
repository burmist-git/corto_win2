#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Wed Aug 30 10:19:34 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script check if a given task is running on  #
#                     screen with given name.                          #
#                     return 1 - if running                            #
#                     return 0 - if NOT running                        #
#                                                                      #
# Input paramete:                                                      #
#                 [1] - screen name                                    #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash > /dev/null


check_if_screen_isRunning () {

    #echo $1

    nobj=$(screen -ls | grep $1 | wc -l)
    
    #echo "nobj = $nobj"
    
    if [ "$nobj" -eq 0 ]
    then
	echo " --> screen with name: $1 is NOT running "
	return 0;
    else
	echo " --> screen with name: $1 is running "
	return 1;
    fi
}

nPar=$#

if [ "$nPar" -eq 1 ]
then
    
    #echo $1

    check_if_screen_isRunning $1
    
else
    echo " ---> ERROR in input arguments : "
    echo "                                [1] screen name"
    echo " ---> Script description :"
    echo "                           This script check if a given task is running on"
    echo "                           screen with given name."
fi


