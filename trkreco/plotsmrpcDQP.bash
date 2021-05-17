#!/bin/bash

########################################################################
#                                                                      #
# Sun Jul  9 16:46:07 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script provide data quality plots from the  # 
#                     root histograms for ALL MRPCs.                   #
#                                                                      #
# Input paramete:                                                      #
#                     [1] Run name                                     #
########################################################################

#CORTOWINRUNNAME="Run_0012_10.02.2017.22.25.22"                # Run name with measurements
#CORTOWINRUNNAMEWF="Run_0012_Data_2_10_2017_Binary"            # Run name with WF

CORTOWINRUNNAME=$1
#CORTOWINRUNNAMEWF=$2
nPar=$#

if [ "$nPar" -eq 1 ]
then
    
    CORTOWINROOTL1PATHFULL=$CORTOWINHOME"/"$CORTOWINDATAROOTL1"/" # Root L1 full path
    
    outDQPpdf=$CORTOWINHOME$CORTOWINDQP"/"$CORTOWINRUNNAME"/"
    mkdir -p $outDQPpdf
    outDQPpdfFullPath=$outDQPpdf$CORTOWINMRPCDQPNAME
    
    nn=${#CORTOWINUSBWCCARTEIDarr[@]}
    let nn=nn-2
    
    for i in `seq 0 $nn`;
    do
	# 1.2, 1.1, 1.3
	inFileN=$CORTOWINHOME$CORTOWINDQH"/"$CORTOWINRUNNAME"/"$CORTOWINHISTPREF${CORTOWINUSBWCMAParr[$i]}$CORTOWINROOTSUFF
	outFileN=$CORTOWINHOME"/"$CORTOWINANA"/"$CORTOWINTRK"/outFileTmp"${CORTOWINUSBWCMAParr[$i]}'.pdf'
	outFileNarr[$i]=$outFileN
	#echo $inFileN
	#echo $outFileN
	#root -l -b -q "./trkreco/plotsmrpcDQP.C( \"$inFileN\"\")"> /dev/null 2>&1
	#root -l -b -q "./trkreco/plotsmrpcDQP.C( \"$inFileN\"\")"
	root -l -b -q "$CORTOWINHOME$CORTOWINANA/$CORTOWINTRK/plotsmrpcDQP.C( \"$inFileN\", \"$outFileN\" )"
	#root -l -b -q "./trkreco/.C( \"$inFileN\"\")"
	#mv outFileTmp.pdf outFileTmp${CORTOWINUSBWCMAParr[$i]}'.pdf'
	#else  # 1.7
        #echo "NON"
    done
    mrpcpdfarr=(
	"$CORTOWINHOME/$CORTOWINANA/$CORTOWINTRK/topmrpc.pdf"
	"$CORTOWINHOME/$CORTOWINANA/$CORTOWINTRK/midmrpc.pdf"
	"$CORTOWINHOME/$CORTOWINANA/$CORTOWINTRK/botmrpc.pdf"
    )

    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$outDQPpdfFullPath ${mrpcpdfarr[0]} ${outFileNarr[0]} ${mrpcpdfarr[1]} ${outFileNarr[1]} ${mrpcpdfarr[2]} ${outFileNarr[2]}

    #gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$outDQPpdfFullPath ${mrpcpdfarr[0]} outFileTmp${CORTOWINUSBWCMAParr[0]}'.pdf' ${mrpcpdfarr[1]} outFileTmp${CORTOWINUSBWCMAParr[1]}'.pdf' ${mrpcpdfarr[2]} outFileTmp${CORTOWINUSBWCMAParr[2]}'.pdf'
    #echo "gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$outDQPpdfFullPath topmrpc.pdf outFileTmp${CORTOWINUSBWCMAParr[0]}'.pdf' midmrpc.pdf outFileTmp${CORTOWINUSBWCMAParr[1]}'.pdf' botmrpc.pdf outFileTmp${CORTOWINUSBWCMAParr[2]}'.pdf'"
    
    echo "DQP are here : "$outDQPpdfFullPath

else #if [ "$nPar" -eq 2 ]
    echo " ---> ERROR in input arguments : "
    echo "                                [1] Run name"
    #echo "                                [2] Run name with waveform"
    echo " ---> Script description :"
    echo "                           This script provide data quality plots from the"
    echo "                           root histograms for ALL MRPCs."
fi
