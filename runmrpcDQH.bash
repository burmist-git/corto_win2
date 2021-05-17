#!/bin/bash

########################################################################
#                                                                      #
# Fri Jul 14 16:56:10 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script provide data quality histogramming   # 
#                     for all MRPC.                                    #
#                                                                      #
# Input paramete:                                                      #
#                 run this script without parameters for help.         #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

. /home/gred/corto_win2/ana/setupCORTOWINworkspace.bash
. /home/gred/corto_win2/ana/currentRunName.bash
. /home/gred/corto_win2/ana/setupLocale.bash

source $ROOTSHPULLPATH

runmrpcDQH () {
    echo " ---> BEGIN runmrpcDQH.bash <--- "
    echo ""
    date
    echo ""
    echo ""    
    CORTOWINRUNNAME=$1                                            # Run name with measurements		
    nPar=$#    
    if [ "$nPar" -eq 1 ]
    then	
	CORTOWINROOTL1PATHFULL=$CORTOWINHOME"/"$CORTOWINDATAROOTL1"/" # Root L1 full path		
	#echo "CORTOWINROOTL1PATHFULL=$CORTOWINROOTL1PATHFULL"
	nn=${#CORTOWINUSBWCCARTEIDarr[@]}
	let nn=nn-2
	for i in `seq 0 $nn`;
	do
	    inDataFolder=$CORTOWINROOTL1PATHFULL$CORTOWINRUNNAME"/"${CORTOWINUSBWCMAParr[$i]}"/"
	    outFileListFullPath=$CORTOWINHOME$CORTOWINANA"/"$CORTOWINTRK"/"$CORTOWINLISTPREF${CORTOWINUSBWCMAParr[$i]}$CORTOWINDATSUFF
	    outHistFolder=$CORTOWINHOME$CORTOWINDQH"/"$CORTOWINRUNNAME"/"
	    mkdir -p $outHistFolder
	    echo "outHistFolder = $outHistFolder"
	    outHistF=$outHistFolder$CORTOWINHISTPREF${CORTOWINUSBWCMAParr[$i]}$CORTOWINROOTSUFF
	    echo "inDataFolder = $inDataFolder"
	    echo "outFileListFullPath = $outFileListFullPath"
	    echo "outHistF = $outHistF"
	    makeFileList.bash $inDataFolder $outFileListFullPath
	    #echo "runmrpc 1 ${CORTOWINMRPCCALIBarr[$i]} $outFileListFullPath $outHistF"
	    runmrpc 1 ${CORTOWINMRPCCALIBarr[$i]} $outFileListFullPath $outHistF
	done	
	echo ""
	echo ""
	source ./trkreco/plotsmrpcDQP.bash $runname
	echo ""
	echo ""
    else
	echo " ---> ERROR in input arguments : "
	echo "                                [1] Run name with measurements"
	echo " ---> Script description :"
	echo "                           This script provide data quality histogramming " 
	echo "                           for all MRPC."
    fi    
    echo ""
    echo ""
    date
    echo ""
    echo " ---> END runmrpcDQH.bash <--- "    
    return 1
}

printHelp () {
    echo " <b> ---> ERROR while executing runmrpcDQH.bash </b> "
    echo " <b> ---> ERROR in input arguments </b> "
    echo " <b> -------------------------------- </b> "
    echo "        <b> Take defaule value of run name from runname file </b>"
    echo "                               no parameters to pass (screen mode) "
    echo " <b> -------------------------------- </b> "
    echo "        <b> Print this help mesage </b>"
    echo "                               [1] : 0 (execution ID) "
    echo " <b> -------------------------------- </b> "
    echo "        <b> Take defaule value of run name from runname file </b>"
    echo "                               [1] : 1 (execution ID) "
    echo "                               [2] : Run name (from root_data_L1) "
    echo " <b> ---> Script description :"
    echo "                           This script provide data quality histogramming"
    echo "                           for all MRPC."
    return 0
}

nPar=$#
if [ "$nPar" -eq 0 ]
then
    runname=$CORTOWINCURRENTRUNNAME
    echo "$runname"
    #return 1
    outlog=$CORTOWINHOME"/"$CORTOWINLOG"/"$runname
    mkdir -p $outlog
    outlogFull=$outlog"/runmrpcDQH"$CORTOWINLOGSUFF
    echo $outlog
    echo $outlogFull
    runmrpcDQH $runname | tee $outlogFull
fi

if [ "$nPar" -gt 0 ]
then
    if [ "$nPar" -eq 1 ]
    then
	if [ $1 -eq 0 ]
	then
	    printHelp
	fi
    fi
    if [ "$nPar" -eq 2 ]
    then
	if [ $1 -eq 1 ]
	then
	    runname=$2
	    outlog=$CORTOWINHOME"/"$CORTOWINLOG"/"$runname
	    mkdir -p $outlog
	    outlogFull=$outlog"/runmrpcDQH"$CORTOWINLOGSUFF
	    echo $outlog
	    echo $outlogFull
	    runmrpcDQH $runname | tee $outlogFull
	    return 1
	else
	    printHelp
	fi
    fi
fi
