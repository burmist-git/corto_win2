########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Sun Sep  3 18:20:17 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script perform compilation dataanastatus.   #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

ROOTCFLAGS    = $(shell $(ROOTSYS)/bin/root-config --cflags)
ROOTLIBS      = $(shell $(ROOTSYS)/bin/root-config --libs)
ROOTGLIBS     = $(shell $(ROOTSYS)/bin/root-config --glibs)

CXX  = g++
CXX += -I./	

CXXFLAGS  = -g -Wall -fPIC -Wno-deprecated
CXXFLAGS += $(ROOTCFLAGS)

OUTBIN = $(CORTOWINDATABINFULLPATH)

#----------------------------------------------------#

all: makedir dataanastatus

makedir: 
	mkdir -p $(OUTBIN)

dataanastatus: dataanastatus.cc
	$(CXX) -o $(OUTBIN)dataanastatus dataanastatus.cc  $(ROOTCFLAGS) $(ROOTLIBS) $(ROOTGLIBS) 

clean:
	rm -f $(OUTBIN)dataanastatus
	rm -f *~
