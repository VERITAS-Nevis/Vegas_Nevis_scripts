#!/bin/bash

runlist=$1
method=$2
#stage=$3

bindir=/a/home/tehanu/dribeiro/Analysis/scripts
rundir=/a/home/tehanu/dribeiro/Analysis/Crab/runlists/stage6/PerRun
configdir=/a/home/tehanu/dribeiro/Analysis/Crab/stage6/PerRun
storage=/a/data/ged/dribeiro/Crab/2_5_4/Stage6files

cuts=(soft hard med)
cut=med

while read line           
do  
  #echo "Starting run ${line}"
    prefix=${line}-${cut}-${method}
    st6runlist=${prefix}.txt
    fullrunlist=${rundir}/${st6runlist}
    #echo "Creating stage 6 files for ${prefix}" 
    echo "${bindir}/specst6_Crab.sh ${fullrunlist} ${storage}/ ${prefix}"
    #${bindir}/specst6_Crab.sh ${fullrunlist} ${storage}/ ${prefix}
    #echo "Finished ${prefix}" 
  #echo "Finished run ${line}"
  continue
done <$runlist

