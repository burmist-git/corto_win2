#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Jul  7 21:22:40 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script creats list of all files in          #
#                     the folder.                                      #
#                                                                      #
# Input paramete: [1] path to the folder with files                    #
#                 [2] output list file full path                       #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

fileListFolder=$1
outFileListFullPath=$2
nPar=$#

if [ "$nPar" -eq 2 ]
then
    echo " ---> BEGIN makeFileList.bash <--- "
    cd $fileListFolder
    echo "fileListFolder=$fileListFolder"
    echo "outFileList=$outFileListFullPath"
    rm -f $outFileListFullPath
    for entry in `ls -lrt $search_dir | awk {'print $9'}`; do
	echo $fileListFolder$entry >> $outFileListFullPath
    done
    cd -
    echo " ---> END makeFileList.bash <--- "
else
    echo " ---> ERROR in input arguments : "
    echo "                                [1] path to the folder with files"
    echo "                                [2] output list file full path"
    echo " ---> Script description :"
    echo "                           This script creats list of all files in"
    echo "                           the folder."
fi
