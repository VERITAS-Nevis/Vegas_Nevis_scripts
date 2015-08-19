#!/bin/bash

while read -r line || [[ -n $line ]]
do
    ln -s "/a/data/$2/ap3115/IC443/2_5_4/$line""s1.root" "/a/data/tehanu/ap3115/IC443/2_5_4/$line""s1.root"
    ln -s "/a/data/$2/ap3115/IC443/2_5_4/$line""s2.root" "/a/data/tehanu/ap3115/IC443/2_5_4/$line""s2.root"
    ln -s "/a/data/$2/ap3115/IC443/2_5_4/$line""s4-med.root" "/a/data/tehanu/ap3115/IC443/2_5_4/$line""s4-med.root"
    ln -s "/a/data/$2/ap3115/IC443/2_5_4/$line""s5-med.root" "/a/data/tehanu/ap3115/IC443/2_5_4/$line""s5-med.root"
    ln -s "/a/data/$2/ap3115/IC443/2_5_4/$line""s5-med-com.root" "/a/data/tehanu/ap3115/IC443/2_5_4/$line""s5-med-com.root"
done < $1
    
