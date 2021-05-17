#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Jul 14 16:56:10 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script provide track reconstruction quality # 
#                     histogramming.                                   # 
#                                                                      #
# Input paramete: NON                                                  #
#                     [1] Run name with measurements                   #
#                     [2] Run name with WF                             #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash
. /home/gred/corto_win2/ana/currentRunName.bash

runtrkrecoDQH () {

    echo " ---> BEGIN runtrkrecoDQH.bash <--- "
    echo "DDAATTAA : $(date)"
    echo ""
    echo ""
    
    #nPar=$#
    #if [ "$nPar" -eq 2 ]
    #then
	
    #CORTOWINRUNNAME=$CORTOWINCURRENTRUNNAME
    CORTOWINRUNNAME="Run_0005_11.09.2017.12.01.55"
    
    #CORTOWINRUNNAME=$1              # Run name with measurements
    #CORTOWINRUNNAMEWF=$2            # Run name with WF
    
    #echo $CORTOWINRUNNAME
    #echo $CORTOWINRUNNAMEWF
    
    #echo ""
    #echo ""
    #echo "######################################################"
    #make -f Makefile cleanruntrkreco; make -f Makefile runtrkreco;
    #echo "######################################################"
    #echo ""
    #echo ""

    #inDataFolder[0]=$CORTOWINHOME"/"$CORTOWINDATAROOTL1"/"$CORTOWINRUNNAME"/"${CORTOWINUSBWCMAParr[0]}"/"
    #inDataFolder[1]=$CORTOWINHOME"/"$CORTOWINDATAROOTL1"/"$CORTOWINRUNNAME"/"${CORTOWINUSBWCMAParr[1]}"/"
    #inDataFolder[2]=$CORTOWINHOME"/"$CORTOWINDATAROOTL1"/"$CORTOWINRUNNAME"/"${CORTOWINUSBWCMAParr[2]}"/"
    #echo ${inDataFolder[0]}
    #echo ${inDataFolder[1]}
    #echo ${inDataFolder[2]}
    
    outFileListFullPath[0]=$CORTOWINHOME$CORTOWINANA"/"$CORTOWINTRK"/"$CORTOWINLISTL2PREF${CORTOWINUSBWCMAParr[0]}$CORTOWINDATSUFF
    outFileListFullPath[1]=$CORTOWINHOME$CORTOWINANA"/"$CORTOWINTRK"/"$CORTOWINLISTL2PREF${CORTOWINUSBWCMAParr[1]}$CORTOWINDATSUFF
    outFileListFullPath[2]=$CORTOWINHOME$CORTOWINANA"/"$CORTOWINTRK"/"$CORTOWINLISTL2PREF${CORTOWINUSBWCMAParr[2]}$CORTOWINDATSUFF
    
    #echo ${outFileListFullPath[0]}
    #echo ${outFileListFullPath[1]}
    #echo ${outFileListFullPath[2]}
    
    #makeFileList.bash ${inDataFolder[0]} ${outFileListFullPath[0]}
    #makeFileList.bash ${inDataFolder[1]} ${outFileListFullPath[1]}
    #makeFileList.bash ${inDataFolder[2]} ${outFileListFullPath[2]}

    outHistFolder=$CORTOWINHOME$CORTOWINDQH"/"$CORTOWINRUNNAME"/"
    mkdir -p $outHistFolder
    outHistF=$outHistFolder$CORTOWINHISTRKTPREF$CORTOWINROOTSUFF
    #echo $outHistF

    runtrkreco 0 ${outFileListFullPath[0]} ${outFileListFullPath[1]} ${outFileListFullPath[2]} ${CORTOWINMRPCCALIBarr[0]} ${CORTOWINMRPCCALIBarr[1]} ${CORTOWINMRPCCALIBarr[2]} $outHistF
    
    #else
    #    echo " ---> ERROR in input arguments : "
    #    echo "                                [1] Run name with measurements"
    #    echo "                                [2] Run name with WF"
    #    echo " ---> Script description :"
    #    echo "                           This script provide track reconstruction quality " 
    #    echo "                           histogramming."
    #fi
    
    echo ""
    echo ""
    echo "DDAATTAA : $(date)"
    echo " ---> END runmrpcDQH.bash <--- "
    
}

runtrkrecoDQH
