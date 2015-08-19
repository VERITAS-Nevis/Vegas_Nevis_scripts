#!/bin/bash

# create original list from input file
declare -a list
count=0
while read -r line || [[ -n $line ]] 
do
    list[count]=$line
    ((count++))
done < $1

# now randomize -- Fisher-Yates shuffle
i=$((count-1))
while [ $i -gt 0 ]
do
    # get a random index
    j=$(($RANDOM % (i+1) ))
    # exchange it with the tail of the array
    lj=${list[j]}
    list[j]=${list[i]}
    list[i]=$lj
 
    ((i--))
done

for i in `seq 0 $((count-1))`
do
    echo ${list[i]}
done

exit 0;
