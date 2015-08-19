#! /bin/bash

RUNLIST=$1
SCRIPTSDIR=/a/home/tehanu/humensky/Analysis/scripts
RAWDIR=/a/data/tehanu/humensky/Raw/Flasher
DATADIR=/a/data/tehanu/humensky/Flasher

mkdir $SCRIPTSDIR/temp

last=1

while read line
  do [ -z "$line" ] && break;
  laser=`echo $line | cut -d" " -f2`;
  if [ $last -ne $laser ]; then
    cp $SCRIPTSDIR/LaunchCalibration.cmd LaunchCalibrationTEMP.cmd;
    echo "Requirements = Memory > 2000";
    echo output = $DATADIR/temp/Cali_${data}.out >> LaunchCalibrationTEMP.cmd;
    echo error  = $DATADIR/temp/Cali_${data}.err >> LaunchCalibrationTEMP.cmd;
    echo log    = $DATADIR/temp/Cali_${data}.log >> LaunchCalibrationTEMP.cmd;
    echo initialdir = $DATADIR/temp >> LaunchCalibrationTEMP.cmd;
    echo RawDir = $RAWDIR;
    echo DataDir = $DATADIR >> LaunchCalibrationTEMP.cmd;
    echo RunNumber = $laser >> LaunchCalibrationTEMP.cmd;
    echo queue 1 >> LaunchCalibrationTEMP.cmd;
    condor_submit LaunchCalibrationTEMP.cmd;
    last=$laser
  fi
done < $RUNLIST

exit
