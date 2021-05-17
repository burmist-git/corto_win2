########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Jul  7 12:06:19 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script perform cmpilation ot the corto DAQ  #
#                     modules.                                         #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
########################################################################

OUTBIN = $(CORTOWINDATABINFULLPATH)

#----------------------------------------------------#

all: makedir rawdataconversion trkreconstruction toolss 

makedir: 
	mkdir -p $(OUTBIN)

rawdataconversion:
	make -C ./rawdataconv/ -f Makefile

trkreconstruction:
	make -C ./trkreco/ -f Makefile

toolss:
	make -C ./tools/ -f Makefile

clean:
	make -C ./rawdataconv/ -f Makefile clean
	make -C ./trkreco/ -f Makefile clean
	make -C ./tools/ -f Makefile clean
	rm -rf $(OUTBIN)
	rm -f $(CORTOWINTOOLSFULLPATH)*~
	rm -f *~
