#!/bin/bash

. ${NevisAppBase}/adm/nevis-init.sh

HOME=/a/home/tehanu/$USER

CUTSDIR=${HOME}/Analysis/Cuts
export ROOTSYS=/usr/nevis/root-05.34.23
export PATH=$ROOTSYS/bin:$PATH
export LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH

dataRun=$1
server=$2
rawFile=$3
flasherRun=$4
rawdir=$5
outdir=$6
#stage4table="-table $LT/lt_Nov2010_oa_ATM21_7samples_vegasv240rc1_hfit25_allOffsets_LZA.root"
stage4table=$7
lndir=$8
stcode=$9
version=${10}
disptable=${11}
flasherFile=/a/data/$server/$USER/Flasher/$version/$flasherRun.root
cali_dir=/a/data/tehanu/$USER/Flasher/$version
#  The stage code string is currently NN characters long
#  0 - run stage 1? 0=no, 1=yes
#  1 - run stage 2? 0=no, 1=yes, 2=hfit
#  2 - run stage 4? 0=no, 1=geo, 2=disp, 4=mix
#  3 - run stage 5 regular? 0=no, 1=yes
#  4 - run stage 5 combined? 0=no, 1=yes
#  5 - write calibrated events at st2? 0=no, 1=yes
#  6 - cuts to run at st4? 0=soft, 1=med, 2=hard, 3=all
#  7 - epoch of data 4=V4, 5=V5, 6=V6
st1code=${stcode:0:1}
st2code=${stcode:1:1}
st4code=${stcode:2:1}
st5code=${stcode:3:1}
st5comcode=${stcode:4:1}
st2opt=${stcode:5:1}
#st2vpm=${stcode:6:1}
st4cuts=${stcode:6:1}
epoch=${stcode:7:1}

vegas=/a/home/tehanu/ap3115/software/veritas/vegas-v$version

suffix="-disp_new"  #default is "_"

echo ==============================================================
date
echo   Server         = $server
echo   Run \#         = $dataRun
echo   Flasher \#     = $flasherRun
echo   CVBF Dir       = $rawdir
echo   Out Dir        = $outdir
echo   Raw Data       = $rawFile
echo   Flasher File   = $flasherFile
echo   Main Calib Dir = $cali_dir
echo   Lookup Table   = $stage4table
echo   Link Dir       = $lndir
echo   Stage Code     = $stcode
echo   VERITAS Epoch  = V$epoch
echo   Vegas Version  = $vegas
echo ==============================================================
echo st1code = $st1code
echo st2code = $st2code
echo st4code = $st4code
echo st5code = $st5code
echo st5comcode = $st5comcode
echo st2opt = $st2opt

if [ ! -d $outdir ] ; then
    mkdir $outdir
fi
if [ ! -d $lndir ] ; then
    mkdir $lndir
fi
cd $DATADIR

# Set up options for all stages

st1cfg=$outdir/tmp_${dataRun}_s1.cfg
st2cfg=$outdir/tmp_${dataRun}_s2.cfg
st4cfg=$outdir/tmp_${dataRun}_s4.cfg
st5cfg=$outdir/tmp_${dataRun}_s5.cfg
st4cut=$outdir/tmp_${dataRun}_s4.cut
st5cut=$outdir/tmp_${dataRun}_s5.cut

stage1options="-G_GlobalProgressPrintFrequency=50000 -QSCTD_MinSumWinWidth=4  -Stage1_DBHost=remus.ucsc.edu"
stage2options="-G_GlobalProgressPrintFrequency=50000 -Hillas2DCalc=Null "
if [ $st2code -eq 2 ]; then
    stage2options=$stage2options" -HillasFitAlgorithum=2DEllipticalGaussian "
fi
#if [ $st2code -eq 4 -o $st2code -eq 6 ]; then
#    stage2options=$stage2options" -UseTimeProfile=true -LGDL_Algorithm=LowGainDataLoaderFromFile -LGDLFF_FileName=$vegas/common/lowGainDataFiles/59946-59947_doublepass.root "
#fi
if [ $st2opt -eq 1 ]; then
    stage2options=$stage2options" -Stage2_WriteCalibratedEvents=1 "
fi
#if [ $st2vpm -eq 1 ]; then
#    stage2options=$stage2options" -S2A_UseVPMPointing=1 "
#fi
echo Stage1 options = $stage1options
echo Stage2 options = $stage2options

#-CutTelescope=3/1 -OverrideLTCheck=1

#stage4optionsMed=" -cuts $CUTSDIR/gc.cut -LTM_WindowSizeForNoise=7 -DR_Algorithm=Method5 -DR_DispTable=$DT/dt_Nov2010_na_ATM22_7samples_vegasv240rc1_LZA.root "
#stage4optionsMed=" -cuts $CUTSDIR/med.cut -LTM_WindowSizeForNoise=7 "


stage4options="-G_SimulationMode=1 -G_GlobalProgressPrintFrequency=50000 -LTM_WindowSizeForNoise=7 -DR_DispTable=$disptable -OverrideLTCheck=1"
#if [ $epoch -eq 4 ]; then
#    if [ $dataRun -lt 36000 ]; then
#        stage4options=$stage4options" -TelCombosToDeny=ANY2 "
##        stage4options=$stage4options" -TelCombosToDeny=T1T4"
#    else
#	stage4options=$stage4options" -TelCombosToDeny=ANY2,ANY3 "
##        stage4options=$stage4options" -TelCombosToDeny=T1T4"
#    fi
#elif [ $epoch -eq 5 ]; then
#    stage4options=$stage4options" -TelCombosToDeny=ANY2 "
#elif [ $epoch -eq 6 ]; then
#    stage4options=$stage4options" -TelCombosToDeny=ANY2 "
#fi


HFitCuts=""
if [ $st2code -eq 2 -o $st2code -eq 4 ]; then
    stage4options=$stage4options" -HillasBranchName HFit "
    HFitCuts="-hfit"
else
    stage4options=$stage4options"   "
fi
if [ $st4code -eq 2 ]; then
    stage4options=$stage4options" -DR_Algorithm=Method5t " #currently set to '5', meaning disp_old. must reset to '5t' for disp_new 
fi
if [ $st4code -eq 4 ]; then
    stage4options=$stage4options" -DR_Algorithm=Method6 "
fi

if [ $epoch -lt 6 ]; then
    stage4optionsMed="-cuts $CUTSDIR/st4med_V45$HFitCuts.cut -LTM_WindowSizeForNoise=7"
    stage4optionsHard="-cuts $CUTSDIR/st4hard_V45$HFitCuts.cut -LTM_WindowSizeForNoise=7"
    stage4optionsSoft="-cuts $CUTSDIR/st4soft_V45$HFitCuts.cut -LTM_WindowSizeForNoise=7"
else
    stage4optionsMed="-cuts $CUTSDIR/st4med$HFitCuts.cut -LTM_WindowSizeForNoise=7"
    stage4optionsHard="-cuts $CUTSDIR/st4hard$HFitCuts.cut -LTM_WindowSizeForNoise=7"
    stage4optionsSoft="-cuts $CUTSDIR/st4soft$HFitCuts.cut -LTM_WindowSizeForNoise=7"
fi

stage5optionsMed="-cuts $CUTSDIR/st5med.cut "
stage5optionsHard="-cuts $CUTSDIR/st5hard.cut "
stage5optionsSoft="-cuts $CUTSDIR/st5soft.cut "

#stage4table="-table $LT/lt_Nov2010_na_ATM21_7samples_vegasv240rc1_allOffsets_LZA.root"

echo Stage4 options = $stage4options
echo           Med: = $stage4optionsMed
echo          Hard: = $stage4optionsHard
echo          Soft: = $stage4optionsSoft

if [ "$dataRun" -eq "$dataRun" ] 2>/dev/null
then
# Set up time cuts
#    if [ $r5 -eq 1 -o $r6 -eq 1 -o $r7 -eq 1 ]; then
{
    while read tcrun tcuts; do
	if [ $tcrun -eq $dataRun ]; then
	    timeCut="-ES_CutTimes="$tcuts
	    echo "Applying time cut(s)" $tcuts to run $tcrun
	    break;
	fi
    done
} < $HOME/Analysis/Cuts/timeCuts.txt
#fi
else
  echo "Not Using an interger, maybe running simulations?"
fi


#    -Method=combined \
stage5options="-G_GlobalProgressPrintFrequency=50000 \
    -MakePlots=1 \
    -Method=stereo \
    -RemoveCutEvents=1 \
    $timeCut \
    -SaveDiagnostics=1 \
    -G_SimulationMode=1"
#    -MeanScaledWidthLower=-1 \
#    -MeanScaledWidthUpper=10 \
#    -MeanScaledLengthLower=-1 \
#    -MeanScaledLengthUpper=10 "

echo Stage5 options = $stage5options

# Run Stage 1
if [ $st1code -gt 0 ]; then
    echo Running stage 1
    date
    $vegas/bin/vaStage1 $stage1options -Stage1_RunMode data -save_config=$st1cfg $rawFile $outdir/${dataRun}s1.root  >& $outdir/Log/log${dataRun}s1.log
    cat $st1cfg >> $outdir/Log/log${dataRun}s1.log
    rm $st1cfg
    ln -f -s $outdir/${dataRun}s1.root $lndir/${dataRun}s1.root
    ln -f -s $outdir/Log/log${dataRun}s1.log $lndir/Log/log${dataRun}s1.log
fi


# Run Stage 2
if [ $st2code -eq 1 -o $st2code -eq 2 ]; then
  if [ "$dataRun" -eq "$dataRun" ] 2>/dev/null
  then
    # Check for the flasher file and copy it if necessary
    if [ ! -e $flasherFile ] ; then

    cp $cali_dir/$flasherRun.root $flasherFile
    fi
    if [ ! -e $flasherFile ] ; then
      echo "Uhoh! Can't find the flasher file $flasherFile so no point continuing."
      exit 1
    fi
    echo Running stage 2
    date
    cp ${outdir}/${dataRun}s1.root $outdir/${dataRun}s2.root
    $vegas/bin/vaStage2 $stage2options $rawFile -save_config=$st2cfg $outdir/${dataRun}s2.root $flasherFile >& $outdir/Log/log${dataRun}s2.log
    cat $st2cfg >> $outdir/Log/log${dataRun}s2.log
    rm $st2cfg
    ln -f -s $outdir/${dataRun}s2.root $lndir/${dataRun}s2.root
    ln -f -s $outdir/Log/log${dataRun}s2.log $lndir/Log/log${dataRun}s2.log
  else
    echo Running stage 2 for simulations...
    date
    echo "$vegas/bin/vaStage2 -G_SimulationMode=1 $stage2options $rawFile -save_config=$st2cfg $outdir/${dataRun}s2.root >& $outdir/Log/log${dataRun}s2.log"
    $vegas/bin/vaStage2 -G_SimulationMode=1 $stage2options $rawFile -save_config=$st2cfg $outdir/${dataRun}s2.root >& $outdir/Log/log${dataRun}s2.log
    cat $st2cfg >> $outdir/Log/log${dataRun}s2.log
    rm $st2cfg
    ln -f -s $outdir/${dataRun}s2.root $lndir/${dataRun}s2.root
    ln -f -s $outdir/Log/log${dataRun}s2.log $lndir/Log/log${dataRun}s2.log
  fi
fi


# Run Stage 4
if [ $st4code -gt 0 ]; then
    echo Running stage 4
    date
    echo LT is $stage4table
    # Stage 4 soft cuts
    if [ $st4cuts -eq 0 -o $st4cuts -eq 3 ]; then
	echo Running Stage 4 with Soft Cuts...
	cp ${outdir}/${dataRun}s2.root $outdir/${dataRun}s4-soft${HFitCuts}${suffix}.root
	$vegas/bin/vaStage4.2 $stage4options $stage4optionsSoft -table $stage4table -save_config=$st4cfg -save_cuts=$st4cut $outdir/${dataRun}s4-soft${HFitCuts}${suffix}.root  >& $outdir/Log/log${dataRun}s4-soft${HFitCuts}${suffix}.log
	cat $st4cfg >> $outdir/Log/log${dataRun}s4-soft${HFitCuts}${suffix}.log
	rm $st4cfg
        
	cat $st4cut >> $outdir/Log/log${dataRun}s4-soft${HFitCuts}${suffix}.log
	rm $st4cut
	ln -f -s $outdir/${dataRun}s4-soft${HFitCuts}${suffix}.root $lndir/${dataRun}s4-soft${HFitCuts}${suffix}.root
	ln -f -s $outdir/Log/log${dataRun}s4-soft${HFitCuts}${suffix}.log $lndir/Log/log${dataRun}s4-soft${HFitCuts}${suffix}.log
    fi
    # Stage 4 medium cuts
    if [ $st4cuts -eq 1 -o $st4cuts -eq 3 ]; then
	echo Running Stage 4 with Medium Cuts...
	cp ${outdir}/${dataRun}s2.root $outdir/${dataRun}s4-med${HFitCuts}${suffix}.root
	echo "$vegas/bin/vaStage4.2 $stage4options $stage4optionsMed -table $stage4table -save_config=$st4cfg -save_cuts=$st4cut $outdir/${dataRun}s4-med${HFitCuts}${suffix}.root  >& $outdir/Log/log${dataRun}s4-med${HFitCuts}${suffix}.log"
	$vegas/bin/vaStage4.2 $stage4options $stage4optionsMed -table $stage4table -save_config=$st4cfg -save_cuts=$st4cut $outdir/${dataRun}s4-med${HFitCuts}${suffix}.root  >& $outdir/Log/log${dataRun}s4-med${HFitCuts}${suffix}.log
	cat $st4cfg >> $outdir/Log/log${dataRun}s4-med${HFitCuts}${suffix}.log
	rm $st4cfg
	cat $st4cut >> $outdir/Log/log${dataRun}s4-med${HFitCuts}${suffix}.log
	rm $st4cut
	ln -f -s $outdir/${dataRun}s4-med${HFitCuts}${suffix}.root $lndir/${dataRun}s4-med${HFitCuts}${suffix}.root
	ln -f -s $outdir/Log/log${dataRun}s4-med${HFitCuts}${suffix}.log $lndir/Log/log${dataRun}s4-med${HFitCuts}${suffix}.log
    fi
    # Stage 4 Hard Cuts
    if [ $st4cuts -eq 2 -o $st4cuts -eq 3 ]; then
	echo Running Stage 4 with Hard Cuts...
	cp ${outdir}/${dataRun}s2.root $outdir/${dataRun}s4-hard${HFitCuts}${suffix}.root
	$vegas/bin/vaStage4.2 $stage4options $stage4optionsHard -table $stage4table -save_config=$st4cfg -save_cuts=$st4cut $outdir/${dataRun}s4-hard${HFitCuts}${suffix}.root  >& $outdir/Log/log${dataRun}s4-hard${HFitCuts}${suffix}.log
	cat $st4cfg >> $outdir/Log/log${dataRun}s4-hard${HFitCuts}${suffix}.log
	rm $st4cfg
	cat $st4cut >> $outdir/Log/log${dataRun}s4-hard${HFitCuts}${suffix}.log
	rm $st4cut
	ln -f -s $outdir/${dataRun}s4-hard${HFitCuts}${suffix}.root $lndir/${dataRun}s4-hard${HFitCuts}${suffix}.root
	ln -f -s $outdir/Log/log${dataRun}s4-hard${HFitCuts}${suffix}.log $lndir/Log/log${dataRun}s4-hard${HFitCuts}${suffix}.log
    fi
fi



# Run Stage 5 regular
if [ $st5code -gt 0 ]; then
    echo Running stage 5
    date
    # Stage 5 soft cuts
    if [ $st4cuts -eq 0 -o $st4cuts -eq 3 ]; then
	echo Running Stage 5 with Soft Cuts...
	$vegas/bin/vaStage5 $stage5options $stage5optionsSoft -save_config=$st5cfg -save_cuts=$st5cut -inputFile $outdir/${dataRun}s4-soft${HFitCuts}${suffix}.root -outputFile $outdir/${dataRun}s5-soft${HFitCuts}${suffix}.root  >& $outdir/Log/log${dataRun}s5-soft${HFitCuts}${suffix}.log
	cat $st5cfg >> $outdir/Log/log${dataRun}s5-soft${HFitCuts}${suffix}.log
	rm $st5cfg
	cat $st5cut >> $outdir/Log/log${dataRun}s5-soft${HFitCuts}${suffix}.log
	rm $st5cut
	ln -f -s $outdir/${dataRun}s5-soft${HFitCuts}${suffix}.root $lndir/${dataRun}s5-soft${HFitCuts}${suffix}.root
	ln -f -s $outdir/Log/log${dataRun}s5-soft${HFitCuts}${suffix}.log $lndir/Log/log${dataRun}s5-soft${HFitCuts}${suffix}.log
    fi
    # Stage 5 medium cuts
    if [ $st4cuts -eq 1 -o $st4cuts -eq 3 ]; then
	echo Running Stage 5 with Medium Cuts...
	$vegas/bin/vaStage5 $stage5options $stage5optionsMed -save_config=$st5cfg -save_cuts=$st5cut -inputFile $outdir/${dataRun}s4-med${HFitCuts}${suffix}.root -outputFile $outdir/${dataRun}s5-med${HFitCuts}${suffix}.root  >& $outdir/Log/log${dataRun}s5-med${HFitCuts}${suffix}.log
	cat $st5cfg >> $outdir/Log/log${dataRun}s5-med${HFitCuts}${suffix}.log
	rm $st5cfg
	cat $st5cut >> $outdir/Log/log${dataRun}s5-med${HFitCuts}${suffix}.log
	rm $st5cut
	ln -f -s $outdir/${dataRun}s5-med${HFitCuts}${suffix}.root $lndir/${dataRun}s5-med${HFitCuts}${suffix}.root
	ln -f -s $outdir/Log/log${dataRun}s5-med${HFitCuts}${suffix}.log $lndir/Log/log${dataRun}s5-med${HFitCuts}${suffix}.log
    fi
    # Stage 5 hard cuts
    if [ $st4cuts -eq 2 -o $st4cuts -eq 3 ]; then
	echo Running Stage 5 with Hard Cuts...
	$vegas/bin/vaStage5 $stage5options $stage5optionsHard -save_config=$st5cfg -save_cuts=$st5cut -inputFile $outdir/${dataRun}s4-hard${HFitCuts}${suffix}.root -outputFile $outdir/${dataRun}s5-hard${HFitCuts}${suffix}.root  >& $outdir/Log/log${dataRun}s5-hard${HFitCuts}${suffix}.log
	cat $st5cfg >> $outdir/Log/log${dataRun}s5-hard${HFitCuts}${suffix}.log
	rm $st5cfg
	cat $st5cut >> $outdir/Log/log${dataRun}s5-hard${HFitCuts}${suffix}.log
	rm $st5cut
	ln -f -s $outdir/${dataRun}s5-hard${HFitCuts}${suffix}.root $lndir/${dataRun}s5-hard${HFitCuts}${suffix}.root
	ln -f -s $outdir/Log/log${dataRun}s5-hard${HFitCuts}${suffix}.log $lndir/Log/log${dataRun}s5-hard${HFitCuts}${suffix}.log
    fi
fi



#Run Stage 5 combined
if [ $st5comcode -gt 0 ]; then
    echo Running stage 5 combined
    date
    $vegas/bin/vaStage5 $stage5options $stage5optionsMed -Method=combined -save_config=$st5cfg -save_cuts=$st5cut -inputFile $outdir/${dataRun}s4-med${HFitCuts}${suffix}.root -outputFile $outdir/${dataRun}s5-med${HFitCuts}-com${suffix}.root  >& $outdir/Log/log${dataRun}s5-med${HFitCuts}-com${suffix}.log
    cat $st5cfg >> $outdir/Log/log${dataRun}s5-med${HFitCuts}-com${suffix}.log
    rm $st5cfg
    cat $st5cut >> $outdir/Log/log${dataRun}s5-med${HFitCuts}-com${suffix}.log
    rm $st5cut
    ln -f -s $outdir/${dataRun}s5-med${HFitCuts}-com${suffix}.root $lndir/${dataRun}s5-med${HFitCuts}-com${suffix}.root
    ln -f -s $outdir/Log/log${dataRun}s5-med${HFitCuts}-com${suffix}.log $lndir/Log/log${dataRun}s5-med${HFitCuts}-com${suffix}.log
fi


exit
