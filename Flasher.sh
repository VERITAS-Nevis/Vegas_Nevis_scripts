#! /bin/bash

RUNLIST=$1

vbfdir=/scratch/humensky/Raw/Flasher
outdir=/data/humensky/Flasher

while read line
  do [ -z "$line" ] && break;
  N=`echo $line`;
#  mv d2*/*.cvbf ./;
#  vaStage1 -QSCTD_MinSumWinWidth=7 -QSCTD_MaxSumWinWidth=12 -BCI_TraceVarWindow=7 -BCI_GainMin=0.05 -BCI_GainMax=5. -BCI_GainVarMin=0.01 -BCI_GainVarMax=1. -Stage1_RunMode flasher ${N}.cvbf ${N}-laser.root 2>&1 | tee log${N}.laser.log;
  vaStage1 -QSCTD_MinSumWinWidth=7 -QSCTD_MaxSumWinWidth=12 -BCI_TraceVarWindow=7 -Stage1_RunMode flasher $vbfdir/${N}.cvbf $outdir/${N}-laser.root 2>&1 | tee $outdir/log${N}.laser.log;
#  vaStage1 -QSCTD_MinSumWinWidth=7 -QSCTD_MaxSumWinWidth=12 -BCI_TraceVarWindow=7 -Stage1_RunMode flasher ${N}.cvbf ${N}-laser.root 2>&1 | tee log${N}.laser.log;
done < $RUNLIST

exit
