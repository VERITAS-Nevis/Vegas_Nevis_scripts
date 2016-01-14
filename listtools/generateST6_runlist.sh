#!/bin/sh

runlist=$1
sourcename=$2
suffix=$3

#bin_range="_0_3_"
bin_range=""

#Effective Areas:

#V5 geo Winter Med
EA=/a/data/tehanu/ap3115/EAs/vegas-2.5/ea_Oct2012_na_ATM21_vegasv250rc5_7sam_Alloff_s400t2_std_MSW1p1_MSL1p3_MH7_ThetaSq0p01_v1.root

#V6 geo Winter Med 
#EA=/a/data/tehanu/ap3115/EAs/vegas-2.5/ea_Oct2012_ua_ATM21_vegasv250rc5_7sam_Alloff_s700t2_std_MSW1p1_MSL1p3_MH7_ThetaSq0p01_LZA_fixed150.root

#V5 disp-new Winter Med
#V6 disp-new Winter Med
#V5 disp-old Winter Med
#V6 disp-old Winter Med

dir=/a/data/tehanu/dribeiro/${sourcename}/2_5_4/
runlistdir=/a/home/tehanu/dribeiro/Analysis/${sourcename}/runlists/stage6/PerRun

cuts=(med-com)

while read line           
do           
    for cut in ${cuts[*]}; do
        touch $runlistdir/$line-${cut}-${suffix}${bin_range}.txt
        find -L ${dir} -maxdepth 1 -iname "*${line}*s5*${cut}*${suffix}*" > $runlistdir/$line-${cut}-${suffix}${bin_range}.txt 
        echo "[EA ID: 0]" >> $runlistdir/$line-${cut}-${suffix}${bin_range}.txt
        echo "${EA}" >> $runlistdir/$line-${cut}-${suffix}${bin_range}.txt
        echo "[/EA ID: 0]" >>$runlistdir/$line-${cut}-${suffix}${bin_range}.txt
        echo "[CONFIG ID: 0]" >> $runlistdir/$line-${cut}-${suffix}${bin_range}.txt
        echo "S6A_RingSize 0.4" >> $runlistdir/$line-${cut}-${suffix}${bin_range}.txt 
        echo "RBM_SearchWindowSqCut 0.16" >> $runlistdir/$line-${cut}-${suffix}${bin_range}.txt 
        #echo "EnergyLower 0" >> $runlistdir/$line-${cut}-${suffix}${bin_range}.txt 
        #echo "EnergyUpper 3500" >> $runlistdir/$line-${cut}-${suffix}${bin_range}.txt 
        cat /a/home/tehanu/dribeiro/Analysis/Cuts/st5${cut}.cut >> $runlistdir/$line-${cut}-${suffix}${bin_range}.txt
        echo "[/CONFIG ID: 0]" >>$runlistdir/$line-${cut}-${suffix}${bin_range}.txt
    done
done <$runlist


