#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Tue Sep  5 18:17:04 CEST 2017                                        #
# Autor: Leonid Burmistrov, Vsevolod Yeroshenko                        #
#                                                                      #
# Script description:                                                  #
#                     This script counts number of USB-WC bin files    #
#                     written to disc.                                 #
#                                                                      #
# Input paramete:                                                      #
#                 USB-WC program ID :                                  #
#                                   -------------------------          #
#                                   |  0  |  1  |  2  |  3  |          #
#                                   | 1.2 | 1.9 | 1.3 | 1.7 |          #
#                                   | TOP | MID | BOT | USE |          #
#                                   -------------------------          #
#                In case no parameter given check all log files.       #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

ANAFOLDER="/home/gred/corto_win2/ana"
cd $ANAFOLDER
. setupCORTOWINworkspace.bash >/dev/null
. currentRunName.bash

export filesWCNumFromLog=0
export filesWCNumRun_Data=0
export filesWCNumData=0
export filesWCNumRootL1=0

countWCfilesFromLog () {
    logFile=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$1]}"/""logfile.txt"
    #echo $logFile
    #INFO:19h:57min:38s: Run started with 10000000 events required.   
    if [ ! -f $logFile ]; then
	return 0
    fi
    export filesWCNumFromLog=`grep Data $logFile | grep saved | grep $CORTOWINCURRENTRUNNAME | wc -l`
    #export filesWCNumFromLog=`grep Data $logFile | grep saved | grep in | grep file | grep .bin | wc -l`
    #echo "filesWCNum = $filesWCNum"
    . check-USB-WC-status.bash check-USB-WC-runIsOver $1 > /dev/null
    checkStatus=$(echo $?)
    #echo $checkStatus
    if [ "$checkStatus" -eq 0 ]
    then
	let filesWCNumFromLog=$filesWCNumFromLog+1
    fi
    return 1
}

countWCfilesFromRun_Data () {
    runDataFolder=$CORTOWINHOME"/"$CORTOWINDATAPCSERDI"/"${CORTOWINUSBWCMAParr[$1]}"/Run_Data/"$CORTOWINCURRENTRUNNAME"/"
    #INFO:19h:57min:38s: Run started with 10000000 events required.   
    if [ ! -d $runDataFolder ]; then
	export filesWCNumRun_Data=0
	return 0
    fi    
    export filesWCNumRun_Data=`ls -lrt $runDataFolder | grep .bin | nl | wc -l`
    return 1
}

countWCfilesFromData () {
    runDataFolder=$CORTOWINHOME"/"$CORTOWINDATADATA"/"$CORTOWINCURRENTRUNNAME"/"${CORTOWINUSBWCMAParr[$1]}"/"
    #INFO:19h:57min:38s: Run started with 10000000 events required.   
    if [ ! -d $runDataFolder ]; then
	export filesWCNumData=0
	return 0
    fi    
    export filesWCNumData=`ls -lrt $runDataFolder | grep .bin | nl | wc -l`
    return 1
}

countWCfilesFromRootL1 () {
    rootL1DataFolder=$CORTOWINHOME"/"$CORTOWINDATAROOTL1"/"$CORTOWINCURRENTRUNNAME"/"${CORTOWINUSBWCMAParr[$1]}"/"
    #echo $rootL1DataFolder
    #INFO:19h:57min:38s: Run started with 10000000 events required.   
    if [ ! -d $rootL1DataFolder ]; then
	export filesWCNumRootL1=0
	return 0
    fi    
    #echo "ls -lrt $rootL1DataFolder | grep .bin | nl | wc -l"
    export filesWCNumRootL1=`ls -lrt $rootL1DataFolder | grep .root | nl | wc -l`
    #echo $filesWCNumRootL1
    return 1
}

countWCfilesAll () {
    #echo "<table> <tr> <td> MRPC </td> <td> $CORTOWINPCSERDI6 </td> <td> Root L1 </td>"
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-1
    for i in `seq 0 $nn`;
    do
	export filesWCNumFromLog=0
	export filesWCNumRun_Data=0
	export filesWCNumData=0
	export filesWCNumRootL1=0
        if [ $i -le 2 ] # 1.1, 1.2, 1.3
        then
            countWCfilesFromLog $i
            countWCfilesFromRun_Data $i
            countWCfilesFromData $i
            countWCfilesFromRootL1 $i
	    filesWCNumRun_Data_arr[$i]=$filesWCNumRun_Data
	    filesWCNumData_arr[$i]=$filesWCNumData
	    filesWCNumRootL1_arr[$i]=$filesWCNumRootL1
	    #echo "<tr> <td> ${CORTOWINUSBWCMAParr[$i]} </td> <td> $filesWCNumRun_Data </td> <td> $filesWCNumRootL1 </td> </tr>"
            #echo "${CORTOWINUSBWCMAParr[$i]} $filesWCNumFromLog (log) $filesWCNumRun_Data (Run_Data) files are written to $CORTOWINPCSERDI6"]
	    #echo "${CORTOWINUSBWCMAParr[$i]} ${filesWCNumRun_Data_arr[$i]} bin files."
        else  # 1.7
            countWCfilesFromLog $i
	    countWCfilesFromRun_Data $i
            countWCfilesFromData $i
            countWCfilesFromRootL1 $i
	    filesWCNumRun_Data_arr[$i]=$filesWCNumRun_Data
	    filesWCNumData_arr[$i]=$filesWCNumData
	    filesWCNumRootL1_arr[$i]=$filesWCNumRootL1
	    #echo "<tr> <td> ${CORTOWINUSBWCMAParr[$i]} </td> <td> $filesWCNumRun_Data </td> <td> $filesWCNumRootL1 </td> </tr>"
            #echo "${CORTOWINUSBWCMAParr[$i]} $filesWCNumFromLog (log) $filesWCNumRun_Data (Run_Data) files are written to $CORTOWINPCSERDI6"
	    #echo "${CORTOWINUSBWCMAParr[$i]} ${filesWCNumRootL1_arr[$i]} bin files."
        fi
    done
    #echo "</table>"

    ####### PRINT TABLE ##########
    echo "<table> <tr> <td> MRPC </td> <td> $CORTOWINPCSERDI6 </td> <td> pc-corto2 </td> <td> Root L1 </td> <tr> <td> ${CORTOWINUSBWCMAParr[0]} </td> <td> ${filesWCNumRun_Data_arr[0]} </td> <td> ${filesWCNumData_arr[0]} </td> <td> ${filesWCNumRootL1_arr[0]} </td> </tr> <tr> <td> ${CORTOWINUSBWCMAParr[1]} </td> <td> ${filesWCNumRun_Data_arr[1]} </td> <td> ${filesWCNumData_arr[1]} </td> <td> ${filesWCNumRootL1_arr[1]} </td> </tr> <tr> <td> ${CORTOWINUSBWCMAParr[2]} </td> <td> ${filesWCNumRun_Data_arr[2]} </td> <td> ${filesWCNumData_arr[2]} </td> <td> ${filesWCNumRootL1_arr[2]} </td> </tr> <tr> <td> ${CORTOWINUSBWCMAParr[3]} </td> <td> ${filesWCNumRun_Data_arr[3]} </td> <td> ${filesWCNumData_arr[3]} </td> <td> ${filesWCNumRootL1_arr[3]} </td> </tr> </table>"
    ##############################
    
    return 1
}

nPar=$#

if [ "$nPar" -eq 1 ]
then
    
    #echo $1

    countWCfilesFromLog $1
    #countWCfilesFromRun_Data $1
    echo $filesWCNumFromLog
    #echo $filesWCNumRun_Data
    
else

    countWCfilesAll

fi

unset filesWCNumFromLog
unset filesWCNumRun_Data
unset filesWCNumRootL1
unset filesWCNumData
