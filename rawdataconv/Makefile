########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Jul  7 12:06:19 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script perform compilation ot the           #
#                     rawdataconv module.                              #
#                                                                      #
# Input paramete: NON                                                  #
#                                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
########################################################################

ROOTCFLAGS    = $(shell $(ROOTSYS)/bin/root-config --cflags)
ROOTLIBS      = $(shell $(ROOTSYS)/bin/root-config --libs)
ROOTGLIBS     = $(shell $(ROOTSYS)/bin/root-config --glibs)

OUTLIB = ./obj/
CXX  = g++
CXX += -I./	
CXX += -I$(OUTLIB)

CXXFLAGS  = -g -Wall -fPIC -Wno-deprecated
CXXFLAGS += $(ROOTCFLAGS)

OUTBIN = $(CORTOWINDATABINFULLPATH)

#----------------------------------------------------#

all: makedir convertUSBWCMeas2root48ChannelsBinOneToOne

makedir: 
	mkdir -p $(OUTLIB)
	mkdir -p $(OUTBIN)

convertUSBWCMeas2root48ChannelsBinOneToOne: makedir convertUSBWCMeas2root48ChannelsBinOneToOne.cc
	$(CXX) -o $(OUTBIN)convertUSBWCMeas2root48ChannelsBinOneToOne convertUSBWCMeas2root48ChannelsBinOneToOne.cc  $(ROOTCFLAGS) $(ROOTLIBS) $(ROOTGLIBS) 

clean:
	rm -f $(OUTBIN)convertUSBWCMeas2root48ChannelsBinOneToOne
	rm -f *~
	rm -f src/*~
	rm -f $(OUTLIB)*.o
