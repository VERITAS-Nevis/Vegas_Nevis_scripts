#!/bin/bash

while read -r line || [[ -n $line ]]
do
   # readlink -f "$2/$line""s5-med.root"
   echo "/a/data/tehanu/ap3115/IC443/2_5_4/$line""s5-med.root"
done < $1
    
exit
