########################################################################
#                                                                      #
# Copyright(C) 2017 - CORTO Collaboration                              #
# Fri Jul  7 12:06:19 CEST 2017                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                     This script perform cmpilation ot the trkreco    #
#                     module.                                          #
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

all: makedir runmrpc runtrkreco

makedir: 
	mkdir -p $(OUTLIB)
	mkdir -p $(OUTBIN)

runmrpc: makedir runmrpc.cpp obj/mrpc.o obj/mrpcbase.o
	$(CXX) -o $(OUTBIN)runmrpc runmrpc.cpp $(OUTLIB)*.o $(ROOTCFLAGS) $(ROOTLIBS) $(ROOTGLIBS)

obj/mrpc.o: src/mrpc.cpp src/mrpc.hh obj/mrpcbase.o
	$(CXX) $(CXXFLAGS) -c -I. -o $(OUTLIB)mrpc.o $<

obj/mrpcbase.o: src/mrpcbase.cpp src/mrpcbase.hh
	$(CXX) $(CXXFLAGS) -c -I. -o $(OUTLIB)mrpcbase.o $<

runtrkreco: makedir runtrkreco.cpp obj/trkreco.o obj/trkrecobase.o
	$(CXX) -o $(OUTBIN)runtrkreco runtrkreco.cpp $(OUTLIB)*.o $(ROOTCFLAGS) $(ROOTLIBS) $(ROOTGLIBS)

obj/trkreco.o: src/trkreco.cpp src/trkreco.hh src/mrpchit.hh obj/trkrecobase.o
	$(CXX) $(CXXFLAGS) -c -I. -o $(OUTLIB)trkreco.o $<

obj/trkrecobase.o: src/trkrecobase.cpp src/trkrecobase.hh obj/mrpc.o
	$(CXX) $(CXXFLAGS) -c -I. -o $(OUTLIB)trkrecobase.o $<

clean:
	rm -f $(OUTBIN)runtrkreco
	rm -f $(OUTBIN)runmrpc
	rm -f *~
	rm -f src/*~
	rm -f $(OUTLIB)*.o

cleanruntrkreco:
	rm -f $(OUTBIN)runtrkreco
	rm -f *~
	rm -f src/*~
