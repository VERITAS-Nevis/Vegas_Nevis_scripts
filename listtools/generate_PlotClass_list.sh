#!/bin/sh

runlist=$1
sourcename=$2
suffix=$3

datadir=/a/data/tehanu/dribeiro/${sourcename}/2_5_4
st6dir=/a/data/ged/dribeiro/${sourcename}/2_5_4/Stage6files
basename=`basename ${runlist} .txt`
runlistdir=`dirname ${runlist}`
classes_runlist=${runlistdir}/../Classes/${basename}_${suffix}_Plot_Classes.txt
cut=med

while read line           
do           
        find -L ${datadir}/ -maxdepth 1 -iname "*${line}*s2*" -exec readlink {} \; >> ${classes_runlist} 
        echo " " >> ${classes_runlist}
        find -L ${datadir}/ -maxdepth 1 -iname "*${line}*s5*${cut}*${suffix}*" -exec readlink {} \; >> ${classes_runlist} 
        echo " " >> ${classes_runlist}
        find -L ${st6dir}/ -maxdepth 1 -iname "*${line}*${cut}*${suffix}*.root" >> ${classes_runlist} 
        echo " " >> ${classes_runlist}
        echo " " >> ${classes_runlist}
done <$runlist


