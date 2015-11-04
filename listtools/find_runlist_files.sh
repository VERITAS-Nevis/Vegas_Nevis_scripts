#!/bin/sh

runlist=$1
dir=$2
stage=$3

while read line           
do           
    find -L ${dir} -maxdepth 1 -iname "*${line}*${stage}*" -exec readlink {} \;| sort --version-sort 
    echo " "
    done <$runlist


