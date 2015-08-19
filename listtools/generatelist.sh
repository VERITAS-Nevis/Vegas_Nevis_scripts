#!/bin/bash

for file in `ls $1*s5-med.root | sort`
do
    echo ${file:(-16):5}
done

exit 0
