#!/bin/bash

echo "------------------------------------------------------------------------"
echo "#            CCCCCCC  OOOOOOOO  RRRR    TTTTTTTT  OOOOOOOO             #"
echo "#            CC       OO    OO  RR  RR     TT     OO    OO             #"
echo "#            CC       OO    OO  RR  RR     TT     OO    OO             #"
echo "#            CC       OO    OO  RRRR       TT     OO    OO             #"
echo "#            CCCCCCC  OOOOOOOO  RR  RR     TT     OOOOOOOO             #"
echo "------------------------------------------------------------------------"
echo " "
echo "########################################################################"
echo "#                                                                      #"
echo "# Copyright(C) 2017 - CORTO Collaboration                              #"
echo "# Fri Jul  7 12:06:19 CEST 2017                                        #"
echo "# Autor: Leonid Burmistrov                                             #"
echo "#                                                                      #"
echo "# Script description:                                                  #"
echo "#                     This script set up CORTOWIN  working space       #"
echo "#                     For normal operation this script should be       #"
echo "#                     executed like this:                              #" 
echo "#                                 > . setupCORTOWINworkspace.bash      #"
echo "#                                                                      #"
echo "# Input paramete: NON                                                  #"
echo "#                                                                      #"
echo "#                                                                      #"
echo "# This software is provided \"as is\" without any warranty.              #"
echo "#                                                                      #"
echo "########################################################################"

########################  Define for each machine  ###########################
ROOTSHPULLPATH="/home/gred/root_v5.34.34/root_v5.34.34-install/bin/thisroot.sh"
CORTOWINHOMEDIR="/home/gred/corto_win2/"
constCORTObashFile="/home/gred/corto_win2/ana/constCORTO.bash"
cwpcserdi6C="/home/gred/PC-SERDI6-win_C/"
cwpcserdi6L="/home/gred/PC-SERDI6-win_L/"
cwlx2ser="lx2.lal.in2p3.fr"
cwusbwcpc="pc-serdi6.lal.in2p3.fr"
##############################################################################

. $constCORTObashFile

export CORTOWINPCLX2=$cwlx2ser                    # Main lal server
export CORTOWINPCSERDI6=$cwusbwcpc                # PC with USB - WC (CORTO DAQ)
export CORTOWINPCSERDI6MPC=$cwpcserdi6C           # Mount point of the PC-SERDI6-win disk C
export CORTOWINPCSERDI6MPL=$cwpcserdi6L           # Mount point of the PC-SERDI6-win disk L
export CORTOWINHOME=$CORTOWINHOMEDIR              # Home directory of CORTOWIN
export CORTOWININFO="info"                        # Folder with DAQ information
export CORTOWININFOPCSERDI6="pc-serdi6-info"      # Folder with DAQ information
export CORTOWINDATAPCSERDI="datapc-serdi6"        # Symbolic link to the raw data from CORTO
export CORTOWINDATAPCBACKUP="backup-serdi6"       # Symbolic link to the backup data for CORTO
export CORTOWINDATADATA="data"                    # Folder with raw data from CORTO
export CORTOWINDATAROOT="root_data"               # Folder with waveforms root data from CORTO
export CORTOWINDATAROOTL1="root_data_L1"          # Folder with parametrs of waveforms data root data from CORTO
export CORTOWINDATAROOTL2="root_data_L2"          # Folder with trk information
export CORTOWINDATAROOTL3="root_data_L3"          # Folder with histograming
export CORTOWINDQH="dataQualityHisto"             # Folder with data quality root histograms
export CORTOWINDQP="dataQualityPlots"             # Folder with data quality Plots
export CORTOWINLOG="log"                          # Folder with DAQ log files
export CORTOWINANA="ana"                          # Folder with raw data treatment code
export CORTOWINCONV="rawdataconv"                 # Folder with CORTO track reconstruction and DQH and DQP
export CORTOWINTRK="trkreco"                      # Folder with CORTO track reconstruction and DQH and DQP
export CORTOWINDATABIN="bin"                      # Folder with all executable binaries
export CORTOWINTOOLS="tools"                      # Folder with toolsx 
export CORTOWINSTATUSFILE="dataanastatus"         # File containing status of the data analysis from CORTO
export CORTOWINRUNNAMEFILE="runname"              # File containing current run name
export CORTOWINSCREENLOGFILE="screenlog.0"        # Name of the screen log file.
export CORTOWINDATABINFULLPATH=$CORTOWINHOME$CORTOWINANA"/"$CORTOWINDATABIN"/" # Folder with all executable binaries - full path 
export CORTOWINTOOLSFULLPATH=$CORTOWINHOME$CORTOWINANA"/"$CORTOWINTOOLS"/"     # Folder with tools - full path 
export CORTOWINARCHIVEFULLPATH=$CORTOWINPCSERDI6MPL"/CORTO_ARCHIVE/"            # Folder with CORTO arcive 
export CORTOWINLISTPREF="rootFileList_"           # Prefix for root file list 
export CORTOWINLISTL2PREF="rootFileListL2_"       # Prefix for root (L2) file list 
export CORTOWINHISTPREF="hist_"                   # Prefix for output root file with histrograms 
export CORTOWINHISTRKTPREF="hist_trk"             # Prefix for output root file with trk histrograms 
export CORTOWINDATSUFF=".dat"                     # Suffix for txt data files (root file list) 
export CORTOWINLOGSUFF=".log"                     # Suffix for txt log files
export CORTOWINSCREENLOGSUFF=".screen.log"        # Suffix for txt scree log files
export CORTOWINROOTSUFF=".root"                   # Suffix for output root - format files (output root file with histrograms)
export CORTOWINMRPCDQPNAME="mrpcDQP.pdf"          # Suffix for output root - format files (output root file with histrograms)
export CORTOWINSCREENNAMEWEBSER="webserv"         # Name of the screen for WEB server
export CORTOWINSCREENNAMECONV="rawdatco"          # Name of the screen for raw data conversion
export CORTOWINSCREENNAMESYNC="rawdatsy"          # Name of the screen for raw data synchronization
export CORTOWINSCREENNAMEDQP="l1trkdqp"           # Name of the screen for L1 data quality plots (MRPC hits and trk reconstructio)
export CORTOWINRUNISSTARTED="RUNISSTARTED"        # Run status start
export CORTOWINRUNISOVER="RUNISOVER"              # Run status stop
export CORTOWINSYNCISOVER="SYNCISOVER"            # Synchronization status
export CORTOWINCONVISOVER="CONVISOVER"            # Conversion status
export CORTOWINRECOISOVER="RECOISOVER"            # Reconstruction status



export CORTOWINUSBWCCARTEIDarr=(
    1.2
    1.9
    1.3
    1.7
)
export CORTOWINUSBWCMAParr=(
    TOP
    MID
    BOT
    USE
)
export CORTOWINUSBWCCARTEFOLDERarr=(
    Corto_Crate1
    Corto_Crate3
    Corto_Crate2
    Corto_Crate4
)
export CORTOWINMRPCCALIBarr=(
    $CORTOWINHOME$CORTOWINANA"/calibrationConstants/dT_TOP_base.dat"
    $CORTOWINHOME$CORTOWINANA"/calibrationConstants/dT_MID_base.dat"
    $CORTOWINHOME$CORTOWINANA"/calibrationConstants/dT_BOT_base.dat"
)

# check if PATH was updated 
NUMOFLINES=$(env | grep -v CORTOWINDATABINFULLPATH | grep $CORTOWINDATABINFULLPATH | wc -l )
#echo $NUMOFLINES
if [ $NUMOFLINES -eq 0 ]
then
    export PATH=$PATH:$CORTOWINDATABINFULLPATH
    export PATH=$PATH:$CORTOWINTOOLSFULLPATH
    source $ROOTSHPULLPATH
fi
echo ""
echo "|-----------------------------------------------------------------------|"
echo "|                     Folder and path definition                        |"
echo "|-----------------------------------------------------------------------|"
echo "|CORTOWINPCLX2           = $CORTOWINPCLX2                             |"
echo "|CORTOWINPCSERDI6        = $CORTOWINPCSERDI6                       |"
echo "|CORTOWINPCSERDI6MPC     = $CORTOWINPCSERDI6MPC                  |"
echo "|CORTOWINPCSERDI6MPL     = $CORTOWINPCSERDI6MPL                  |"
echo "|CORTOWINHOME            = $CORTOWINHOME                       |"
echo "|CORTOWININFO            =                           $CORTOWININFO               |"
echo "|CORTOWINDATADATA        =                           $CORTOWINDATADATA               |"
echo "|CORTOWINDATAPCSERDI     =                           $CORTOWINDATAPCSERDI      |"
echo "|CORTOWINDATAPCBACKUP    =                           $CORTOWINDATAPCBACKUP      |"
echo "|CORTOWINDATAROOT        =                           $CORTOWINDATAROOT          |"
echo "|CORTOWINDATAROOTL1      =                           $CORTOWINDATAROOTL1       |"
echo "|CORTOWINDATAROOTL2      =                           $CORTOWINDATAROOTL2       |"
echo "|CORTOWINDATAROOTL3      =                           $CORTOWINDATAROOTL3       |"
echo "|CORTOWINDQH             =                           $CORTOWINDQH   |"
echo "|CORTOWINDQP             =                           $CORTOWINDQP   |"
echo "|CORTOWINLOG             =                           $CORTOWINLOG                |"
echo "|CORTOWINANA             =                           $CORTOWINANA                |"
echo "|CORTOWINCONV            =                               $CORTOWINCONV    |"
echo "|CORTOWINTRK             =                               $CORTOWINTRK        |"
echo "|CORTOWINDATABIN         =                               $CORTOWINDATABIN            |"
echo "|CORTOWINTOOLS           =                               $CORTOWINTOOLS          |"
echo "|CORTOWINSTATUSFILE      =                               $CORTOWINSTATUSFILE  |"
echo "|CORTOWINRUNNAMEFILE     =                               $CORTOWINRUNNAMEFILE        |"
echo "|CORTOWINSCREENLOGFILE   =                               $CORTOWINSCREENLOGFILE    |"
echo "|CORTOWINDATABINFULLPATH = $CORTOWINDATABINFULLPATH               |"
echo "|CORTOWINTOOLSFULLPATH   = $CORTOWINTOOLSFULLPATH             |"
echo "|CORTOWINARCHIVEFULLPATH = $CORTOWINARCHIVEFULLPATH   |"
echo "|-----------------------------------------------------------------------|"
echo ""
echo "|---------------------------------------------------|"
echo "|               Prefix/Suffix deff.                 |"
echo "|---------------------------------------------------|"
echo "|CORTOWINLISTPREF        = $CORTOWINLISTPREF            |"
echo "|CORTOWINLISTL2PREF      = $CORTOWINLISTL2PREF          |"
echo "|CORTOWINHISTPREF        = $CORTOWINHISTPREF                    |"
echo "|CORTOWINHISTRKTPREF     = $CORTOWINHISTRKTPREF                 |"
echo "|CORTOWINDATSUFF         = $CORTOWINDATSUFF                     |"
echo "|CORTOWINLOGSUFF         = $CORTOWINLOGSUFF                     |"
echo "|CORTOWINSCREENLOGSUFF   = $CORTOWINSCREENLOGSUFF              |"
echo "|CORTOWINROOTSUFF        = $CORTOWINROOTSUFF                    |"
echo "|CORTOWINMRPCDQPNAME     = $CORTOWINMRPCDQPNAME              |"
echo "|---------------------------------------------------|"
echo ""
echo "|---------------------------------------------------|"
echo "|                Ana status names.                  |"
echo "|---------------------------------------------------|"
echo "|CORTOWINRUNISSTARTED    = $CORTOWINRUNISSTARTED             |"
echo "|CORTOWINRUNISOVER       = $CORTOWINRUNISOVER                |"
echo "|CORTOWINSYNCISOVER      = $CORTOWINSYNCISOVER               |"
echo "|CORTOWINCONVISOVER      = $CORTOWINCONVISOVER               |"
echo "|CORTOWINRECOISOVER      = $CORTOWINRECOISOVER               |"
echo "|---------------------------------------------------|"
echo ""
echo "|---------------------------------------------------|"
echo "|                SCREEN names info.                 |"
echo "|---------------------------------------------------|"
echo "|CORTOWINSCREENNAMEWEBSER = $CORTOWINSCREENNAMEWEBSER                 |"
echo "|CORTOWINSCREENNAMECONV   = $CORTOWINSCREENNAMECONV                |"
echo "|CORTOWINSCREENNAMESYNC   = $CORTOWINSCREENNAMESYNC                |" 
echo "|CORTOWINSCREENNAMEDQP    = $CORTOWINSCREENNAMEDQP                |"
echo "|---------------------------------------------------|"

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
echo "|------------------------------------------------------------------------|"
echo "|                          Calibration constants                         |"
echo "|------------------------------------------------------------------------|"
echo "|${CORTOWINUSBWCMAParr[0]} --> ${CORTOWINMRPCCALIBarr[0]}  |"
echo "|${CORTOWINUSBWCMAParr[1]} --> ${CORTOWINMRPCCALIBarr[1]}  |"
echo "|${CORTOWINUSBWCMAParr[2]} --> ${CORTOWINMRPCCALIBarr[2]}  |"
echo "|------------------------------------------------------------------------|"
echo ""
echo `(env | grep -v CORTOWINDATABINFULLPATH | grep $CORTOWINDATABINFULLPATH)`
echo ""
