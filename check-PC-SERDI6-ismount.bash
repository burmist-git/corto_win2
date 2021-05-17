#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Sat Oct  8 18:16:19 CEST 2016                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script check if PC-SERDI6 with USB-WC raw   #
#                     data is mounted.                                 #
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


serdi6winC=$CORTOWINPCSERDI6MPC
serdi6winL=$CORTOWINPCSERDI6MPL

check_PC_SERDI6_ismountC () {

    nobj=$(timeout 5s ls -1 $serdi6winC | wc -l)\

    if [ "$nobj" -eq 0 ]
    then
	#echo " ---> ERROR : $serdi6winC -> is not mounted"
	echo 0
	return 0
    else
	#echo "$serdi6winC -> is mounted"
	echo 1
	return 1
    fi
    
}

check_PC_SERDI6_ismountL () {
    
    nobj=$(timeout 5s ls -1 $serdi6winL | wc -l)
    
    if [ "$nobj" -eq 0 ]
    then
	#echo " ---> ERROR : $serdi6winL -> is not mounted"
	echo 0
	return 0
    else
	#echo "$serdi6winL -> is mounted"
	echo 1
	return 1
    fi
    
}

nPar=$#

if [ "$nPar" -eq 0 ]
then

    check_PC_SERDI6_ismountC
    
    check_PC_SERDI6_ismountL

else

    if [ $1 = 'C' ]
    then	
	check_PC_SERDI6_ismountC
    elif [ $1 = 'L' ]
    then	
	check_PC_SERDI6_ismountL
    else
	echo " ---> ERROR in input arguments : "
	echo "                                [1] C --> check if disk C is mounted or L  --> check if disk L is mounted"
    fi
    
fi
