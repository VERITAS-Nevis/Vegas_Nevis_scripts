#!/bin/bash

for file in `ls $1*s5-med.root`
do
    ls -lh `readlink -f $file`
done

exit 0
