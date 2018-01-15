#!/bin/sh

runlist=$1
dir=$2
stage=$3

while read line           
do           
    find -L ${dir} -iname "*${line}*${stage}*" ! -iname "*log*" -exec readlink {} \;| sort --version-sort 
    echo " "
    done <$runlist


