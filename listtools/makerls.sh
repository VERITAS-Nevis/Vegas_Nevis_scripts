#!/bin/sh

for file in `ls $1`
do
    length=${#file}-4
    echo $file
    /a/home/tehanu/ap3115/Analysis/scripts/tmp/buildrunlist.sh $1/$file $2 | tee $1/${file:0:length}"fullpath.txt"
done

exit
