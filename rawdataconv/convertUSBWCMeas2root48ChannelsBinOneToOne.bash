#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Thu Jul  6 16:50:37 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script converts data with measurements from #
#                     USB-WC.                                          #
#                                                                      #
# Input paramete: Run the script without parameters.                   #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

ANAFOLDER="/home/gred/corto_win2/ana"

source $ANAFOLDER/setupCORTOWINworkspace.bash >/dev/null
cd $ANAFOLDER
. currentRunName.bash

nPar=$#

if [ "$nPar" -eq 2 ]
then

    CORTOWINRUNNAME=$1
    CORTOWINRUNNAMEWF=$2
    
    #CORTOWINRUNNAME="Run_0012_10.02.2017.22.25.22"               # Run name with measurements
    #CORTOWINRUNNAMEWF="Run_0012_Data_2_10_2017_Binary"           # Run name with WF
    
    CORTOWINDATAPATHFULL=$CORTOWINHOME"/"$CORTOWINDATADATA"/"     # Data full path
    CORTOWINROOTL1PATHFULL=$CORTOWINHOME"/"$CORTOWINDATAROOTL1"/" # Root L1 full path

    echo " ---> BEGIN convertUSBWCMeas2root48ChannelsBinOneToOne.bash <--- "
    echo ""
    date
    #echo "######################################################"
    #make -f Makefile clean; make -f Makefile convertUSBWCMeas2root48ChannelsBinOneToOne;
    #echo "######################################################"
    echo ""
    echo ""
    echo ""
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    #echo "$nn"
    
    # Make list of files 
    for i in `seq 0 $nn`;
    do
	if [ $i -le 2 ] # 1.2, 1.9, 1.3 <-> TOP MID BOT
	then
	    inData=$CORTOWINDATAPATHFULL"/"$CORTOWINRUNNAME"/"${CORTOWINUSBWCMAParr[$i]}"/"
	    #echo 'inData '$inData
	    #outData=$CORTOWINROOTL1PATHFULL${CORTOWINUSBWCCARTEIDarr[$i]}"/"$CORTOWINRUNNAME"/"
	    outData=$CORTOWINROOTL1PATHFULL$CORTOWINRUNNAME"/"${CORTOWINUSBWCMAParr[$i]}"/"
	    if [ ! -d $outData ]; then
		mkdir -p $outData;
	    fi;
	    #########################
	    cd $inData
	    lastSyncFileCount=0
	    for inDataFile in `ls $search_dir`; do
		lastSyncFileNum=""
		numZeros=4-${#lastSyncFileCount}
		for j in `seq 1 $numZero`;
		do
		    if [$numZero -eq 0] 
	       	    then
			$lastSyncFileCount+=1
			break
		    fi
		    lastSyncFileNum+="0"
		done
		lastSyncFileNum+="$lastSyncFileCount"
		$lastSyncFileCount+=1
		if [`less ${CORTOWINUSBWCCARTEIDarr[$i]}.LastSyncFile.log | grep $lastSyncFileNum | wc -l` -eq 0]
		then
		    break
		fi
		#echo $inDataFile
		outDataFile=$inDataFile".root"
		echo $inData"/"$inDataFile
		echo $outData"/"$outDataFile
		cd - > /dev/null
		convertUSBWCMeas2root48ChannelsBinOneToOne 0 $inData"/"$inDataFile $outData"/"$outDataFile
		cd - > /dev/null
	    done
	    cd - > /dev/null
	    #########################
	else  # 1.7 <-> USE
	    #./convertUSBWCMeas2root48ChannelsBinOneToOne
	    echo "NON"
	fi
    done
    echo ""
    echo ""
    date
    echo ""
    echo " ---> END convertUSBWCMeas2root48ChannelsBinOneToOne.bash <--- "
else
    echo " ---> ERROR in input arguments : "
    echo "                                [1] Run name with measurements"
    echo "                                [2] Run name with WF"
    echo " ---> Script description :"
    echo "                           This script converts data with " 
    echo "                           measurements from USB-WC."
fi
