#!/bin/bash

shopt -s expand_aliases # This line is only necessary if you're using bash
source /usr/nevis/adm/nevis-init.sh
#xs. ${NevisAppBase}/adm/nevis-init.sh

HOME=/a/home/tehanu/$USER

#export ROOTSYS=/usr/nevis/root-05.34.23
export PATH=$ROOTSYS/bin:$PATH
export LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH

RunNumber=$1 
Server=$2
version=$3
RawDir=/a/data/$Server/Raw/Flasher # path to .cvbf files
RawFile=$RawDir/$RunNumber.cvbf
OutTehanu=/a/data/tehanu/$USER/Flasher/$version
OutTehanuFile=$OutTehanu/$RunNumber.root
OutLocal=/data/$USER/Flasher/$version
OutLocalFile=$OutLocal/$RunNumber.root
LogFile=$OutLocal/$RunNumber.log

vegas=/a/data/tehanu/dribeiro/software/veritas/vegas_symlink

stage1options="-QSCTD_MinSumWinWidth=2 -QSCTD_MaxSumWinWidth=12 "
#stage1options="-QSCTD_MinSumWinWidth=7 -QSCTD_MaxSumWinWidth=12 -BCI_TraceVarWindow=7 -RGCF_Algorithm=RelGainCalcSimple"

# Run Stage 1 on laser file
$vegas/bin/vaStage1 $stage1options -Stage1_RunMode flasher $RawFile $OutLocalFile > $LogFile 2>&1

cp $OutLocalFile $OutTehanuFile

