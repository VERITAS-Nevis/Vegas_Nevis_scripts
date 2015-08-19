#! /bin/bash

RAWDIR=$1
DATADIR=$2
RUNLIST=$3
LT=$4
LNDIR=$5
SCRIPTSDIR=/a/home/tehanu/humensky/Analysis/scripts

if [ ! -d $SCRIPTSDIR/temp ] ; then
    mkdir $SCRIPTSDIR/temp
fi

while read line
  do [ -z "$line" ] && break;
  data=`echo $line | cut -d" " -f1`;
  flasher=`echo $line | cut -d" " -f2`;
  cut=`echo $line | cut -d" " -f3`;
  cp $SCRIPTSDIR/LaunchParametrization.cmd LaunchParametrizationTEMP.cmd;
  echo output = $SCRIPTSDIR/temp/Param_${data}.out >> LaunchParametrizationTEMP.cmd;
  echo error  = $SCRIPTSDIR/temp/Param_${data}.err >> LaunchParametrizationTEMP.cmd;
  echo log    = $SCRIPTSDIR/temp/Param_${data}.log >> LaunchParametrizationTEMP.cmd;
  echo initialdir = $SCRIPTSDIR/temp >> LaunchParametrizationTEMP.cmd;
  echo RAWDIR = $RAWDIR >> LaunchParametrizationTEMP.cmd;
  echo Datadir = $DATADIR >> LaunchParametrizationTEMP.cmd;
  echo RAWfile = $data >> LaunchParametrizationTEMP.cmd;
  echo FLASHER = $flasher >> LaunchParametrizationTEMP.cmd;
  echo LT = $LT >> LaunchParametrizationTEMP.cmd;
  echo LnDir = $LNDIR >> LaunchParametrizationTEMP.cmd;
  echo queue 1 >> LaunchParametrizationTEMP.cmd;

  if [ -e $SCRIPTSDIR/temp/Param_${data}.out ] ; then
      rm $SCRIPTSDIR/temp/Param_${data}.out
  fi
  if [ -e $SCRIPTSDIR/temp/Param_${data}.err ] ; then
      rm $SCRIPTSDIR/temp/Param_${data}.err
  fi
  if [ -e $SCRIPTSDIR/temp/Param_${data}.log ] ; then
      rm $SCRIPTSDIR/temp/Param_${data}.log
  fi

  condor_submit LaunchParametrizationTEMP.cmd;
done < $RUNLIST

exit
