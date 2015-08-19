#!/bin/bash

while read -r line || [[ -n $line ]]
do
    sed -i s/$line// $2
done < $1

exit 0
