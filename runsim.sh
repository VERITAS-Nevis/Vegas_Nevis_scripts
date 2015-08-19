#!/bin/bash

# A simple bash script to process 1 run through all stages of VEGAS.
# First arg is data run number, second is flasher/laser run number.
# Data must exist in VBFDIR.  All output written to ANADIR.
# E.g, execute with:
#  nohup ./vegas-vanilla.sh 59521 59534 > ana.out 2>&1 &

# For UMN:
#HOST=lucifer1.spa.umn.edu
#PORT=33060
# Else:
HOST=romulus.ucsc.edu
PORT=""

# Raw and Processed Data Directories:
ANADIR=/a/data/ged/ap3115/Sims/2_5_4
OUTDIR=/a/data/tehanu/ap3115/Sims/2_5_4

DATA=$1
mkdir -p $ANADIR/Log
LOOK="/a/data/tehanu/ap3115/LTs/vegas-2.5/$2"
CUT4="/a/home/tehanu/ap3115/Analysis/Cuts/$3""$4.cut"
stage4options=" -G_SimulationMode=true -LTM_WindowSizeForNoise=7 -LTM_LookupTableFile=$LOOK -OverrideLTCheck=1 -cuts $CUT4 "
if [ $4 ]; then
    stage4options=$stage4options" -HillasBranchName HFit "
fi
S4_CMD="vaStage4.2"$stage4options"$ANADIR/$DATA""s4-med.root"
echo "(`date`) Executing command:"
echo $S4_CMD
$S4_CMD > $ANADIR/Log/log${DATA}s4-med.log 2>&1
ln -f -s $ANADIR/${DATA}s4-med.root $OUTDIR/${DATA}s4-med.root
ln -f -s $ANADIR/Log/log${DATA}s4-med.log $OUTDIR/Log/log${DATA}s4-med.log

CUT5="/a/home/tehanu/ap3115/Analysis/Cuts/st5med.cut"
S5_CMD="vaStage5 -G_SimulationMode=true -cuts=$CUT5 -Method=\"VACombinedEventSelection\" -RemoveCutEvents 1 -SaveDiagnostics 1 -inputFile $ANADIR/$DATA""s4-med.root -outputFile $ANADIR/$DATA""s5-med.root"
echo "(`date`) Executing command:"
echo $S5_CMD
$S5_CMD > $ANADIR/Log/log$DATA"s5-med.log" 2>&1
ln -f -s $ANADIR/${DATA}s5-med.root $OUTDIR/${DATA}s5-med.root
ln -f -s $ANADIR/Log/log${DATA}s5-med.log $OUTDIR/Log/log${DATA}s5-med.log

echo "Analysis end time `date`"
