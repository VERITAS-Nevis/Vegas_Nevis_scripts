#!/bin/bash


cd /home/humensky/Analysis/
#vroot=/home/humensky/Analysis/vegas-dev
vroot=/usr/local/veritas/vegas-2.3.0

if [ "$HOSTNAME" = "hastur.uchicago.edu" ]
    then
    echo "Running locally - setting variables from command line"
    RUNFILE=$1
    CONFDIR=$2
    LOGFILE=$3
fi

if [ -e tmpv6_${LOGFILE}.cfg ] ; then
    echo "Deleting "tmpv6_${LOGFILE}.cfg
    rm tmpv6_${LOGFILE}.cfg
fi

echo "runst6.sh starting" > $CONFDIR/$LOGFILE.log
echo "   Running on "$HOSTNAME >> $CONFDIR/$LOGFILE.log
echo "   Starting at " $( date ) >> $CONFDIR/$LOGFILE.log
echo "   Using vegas version in "$vroot >> $CONFDIR/$LOGFILE.log
echo >> $CONFDIR/$LOGFILE.log
echo >> $CONFDIR/$LOGFILE.log

#    -batch -kDoDraw=0 \
#    -TelCombosToDeny=T1T4 \
#    -MeanScaledWidthUpper=1.16 -MeanScaledLengthUpper=1.36 \
#    -G_GlobalDebugLevel=E_FULLDEBUG \
#    -select \
#    -S6A_TestPositionRA=94.24 -S6A_TestPositionDEC=22.54 \
#    -S6A_UserDefinedExclusionList=IC443/stars.dat \
#    -S6A_ExcludeStars=1 -S6A_StarExclusionBMagLimit=5 \
#    -S6A_StarExclusionRadius=0.3 \
#    -S6A_DrawExclusionRegions=3 \
#    -S6A_UserDefinedExclusionList=exclusions.dat \
#    -S6A_ReadFromStage4=true 
#    -S6A_TestPositionRA=94.15 -S6A_TestPositionDEC=22.59 \
#    -S6A_TestPositionRA=94.24 -S6A_TestPositionDEC=22.54 \
#    -S6A_TestPositionRA=94.212 -S6A_TestPositionDEC=22.500 \
#    -S6A_TestPositionRA=94.51 -S6A_TestPositionDEC=22.58 \
#    -EC_AcceptanceLibrary=DecIC443/res_4tel-s500-noT1T4-1s6.root \
#-RBM_CoordinateMode=Galactic 
#    -S6A_TestPositionRA=152.09 -S6A_TestPositionDEC=11.97 \
#    -S6A_TestPositionRA=6.323 -S6A_TestPositionDEC=64.085 \
#    -S6A_TestPositionRA=109.227 -S6A_TestPositionDEC=18.34 \
#    -TelCombosToDeny=ANY2,ANY3 \
#    -S6A_ObsMode="On/Off" \
#    -S6A_TestPositionRA=151.773 -S6A_TestPositionDEC=16.5763 \
$vroot/bin/vaStage6 \
    -S6A_Spectrum=0 \
    -S6A_ReadFromStage5Combined=0 \
    -S6A_Batch=0 \
    -S6A_SuppressRunStats=0 \
    -S6A_SuppressRBMFinalStage=0 \
    -S6A_SuppressWobble=0 \
    -S6A_DrawExclusionRegions=1 \
    -S6A_ExcludeSource=0 -S6A_SourceExclusionRadius=0.4 \
    -S6A_DoRelativeExposure=0 \
    -EC_AcceptanceLibrary=/home/humensky/Analysis/DecIC443/res_dudelookslikealady-2s6.root \
    -S6A_ConfigDir=$CONFDIR -S6A_OutputFileName=res_$LOGFILE \
    -S6A_NumRings=0 \
    -S6A_RingSize=0.3 \
    -S6A_LoadAcceptance=0 \
    -S6A_SaveAcceptance=0 \
    -S6A_AcceptanceLookup=acc_off-padded-thru20110109-fixed-2.root\
    -TelCombosToDeny=ANY2 \
    -MaxHeightLower=7 \
    -MeanScaledWidthLower=0.05 -MeanScaledLengthLower=0.05 \
    -MeanScaledWidthUpper=1.15 -MeanScaledLengthUpper=1.3 \
    -WA_UseGeneralizedLiMa=0 \
    -RBM_RingLowerRadius=0.6 -RBM_RingUpperRadius=0.8 \
    -RBM_SearchWindowSqCut=0.09 \
    -RBM_HistoBinSizeInDegrees=0.025 \
    -save_config=$CONFDIR/tmpv6_${LOGFILE}.cfg \
    -save_cuts=$CONFDIR/tmpv6_${LOGFILE}.cut \
    $RUNFILE 2>&1 | tee -a $CONFDIR/$LOGFILE.log
#    -S6A_AcceptanceLookup=acc_$LOGFILE.root\
#    -RBM_ToleranceRadius=15 \
#    -RBM_HistogramSizeXAxis=30 -RBM_HistogramSizeYAxis=6 \
#    -TelCombosToDeny=ANY2,ANY3 \
# My favorite RBM settings, now defaults:
#    -RBM_RingLowerRadius=0.6 -RBM_RingUpperRadius=0.8 \
#    -RBM_AccFitFunction=SMOOTH \
#    -RBM_AccSmoothingCycles=4 \
#    -RBM_PsiCut=1.7 \
#    -RBM_AccFitMax=2.89 \
#    -RBM_NumPsiBins=29 \
#    -EnergyLower=1000 \
#    -S6A_SaveAcceptance=1 \
#    -S6A_AcceptanceLookup=${LOGFILE}_Acc.root \
#    -TelCombosToDeny=ANY2,T1T2T4,T1T3T4 \
#    -RBM_AccFitFunction=PLEXP \
#    -G_GlobalDebugLevel=E_INFO \
#    -G_GlobalDebugLevel=E_FULLDEBUG \
#    -S6A_SuppressRBMFinalStage=1 \
#    -S6A_DoRelativeExposure=0 \
#    -EC_AcceptanceLibrary=vegas-head-20080505/macros/acctest2.root \
#    -TelCombosToDeny=ANY2 \
#    -S6A_TestPositionRA=94.29 -S6A_TestPositionDEC=22.55 \
#    -S6A_TestPositionRA=94.22 \
#    -S6A_TestPositionDEC=22.55 \
#    -RBM_PsiCut=1.7 \
#    -RBM_AccFitMax=2.89 \
#    -S6A_ExcludeSource=1 \
#    -S6A_ExcludeStars=1 -S6A_ExclusionList=IC443/stars.dat \
#    -RBM_PsiCut=1.7 -RBM_AccFitMax=2.89 \
# Crab coords
#    -S6A_TestPositionRA=83.633 \
#    -S6A_TestPositionDEC=22.014 \
#Luis's optimized cuts:
#    -S6A_MSWUpper=1.01 -S6A_MSLUpper=1.16 \
#    -S6A_RingSize=0.115 -RBM_SearchWindowSqCut=0.013225 \

# My previous RBM Options:
#    -RBM_SearchWindowSqCut=0.013225 \
#    -RBM_MinNumberOnCounts=0 \
#    -RBM_MinNumberOffCounts=0 \
#    -S6A_SuppressRBMFinalStage=1 \
#    -S6A_SuppressRBM=0 \
#    -RBM_HistoBinSizeInDegrees=0.025 \
#    -RBM_RingUpperRadius=0.7 \
#    -RBM_ToleranceRadius=8 -RBM_HistogramWindowRadius=8 \
#    -RBM_HistogramSizeXAxis=6 -RBM_HistogramSizeYAxis=6 \
#    -RBM_PsiCut=2 \
#    -RBM_NumPsiBins=40 \

more $CONFDIR/tmpv6_${LOGFILE}.cfg >> $CONFDIR/$LOGFILE.log
rm $CONFDIR/tmpv6_${LOGFILE}.cfg
echo >> $CONFDIR/$LOGFILE.log
echo >> $CONFDIR/$LOGFILE.log
more $CONFDIR/tmpv6_${LOGFILE}.cut >> $CONFDIR/$LOGFILE.log
rm $CONFDIR/tmpv6_${LOGFILE}.cut
echo >> $CONFDIR/$LOGFILE.log
echo >> $CONFDIR/$LOGFILE.log
echo "Runlist used:" >> $CONFDIR/$LOGFILE.log
more $RUNFILE >> $CONFDIR/$LOGFILE.log
echo >> $CONFDIR/$LOGFILE.log
echo >> $CONFDIR/$LOGFILE.log
exit

    -EC_AcceptanceLibrary=AccCurves/library_429runscor_2_003crab.root \
# Add the following to run in batch mode
#    -batch -S6A_DoDraw=0 \

# Add following two options to generate uncorrelated significance map
#    -RBM_SearchWindowSqCut=0.00001 \
#    -RBM_HistoBinSizeInDegrees=0.01 \

# Add following to change the theta cut (would need 3rd option for light 
# curve)
#    -RBM_SearchWindowSqCut=0.06788 \
#    -S6A_RingSize=0.2605 \
#    -S6A_RingSize=0.148 -RBM_SearchWindowSqCut=0.022 \

# Add following to generate a spectrum
#    -S6A_Spectrum=1 \
#    -S6A_MinFitEnergy=0.3 \
#    -S6A_MaxFitEnergy=2 \
#    -SP_EnergyBining=2 \
#    -S6A_TestPositionRA=94.218 \
#    -S6A_TestPositionDEC=22.502 \

# Add the following to use the alternate power-law/exponential acceptance fn
#    -RBM_AccFitFunction=PLEXP \

# To suppress wobble analysis (final steps)
#    -S6A_SuppressWobble=1 \

# To alter size of valid acceptance
#    -RBM_PsiCut=1.7 \
#    -RBM_AccFitMax=2.89 \

# To play with RBM parameters
#    -RBM_SearchWindowSqCut=0.1 \
#    -RBM_RingLowerRadius=0.8 \
#    -RBM_RingUpperRadius=1.2 \
#    -RBM_HistoBinSizeInDegrees=0.05 \

# To adjust RBM map sizes
#    -RBM_HistogramSizeXAxis=6 \
#    -RBM_HistogramSizeYAxis=6 \
#    -RBM_HistogramWindowRadius=3 \
#    -RBM_ToleranceRadius=6 \
#    -SM_FoVRadius=3    \

# To change gamma/hadron cuts
#    -S6A_MSWLow=0.6 -S6A_MSLLow=0.6 \
#    -S6A_MSWUpper=1.06 -S6A_MSLUpper=1.2 \


# To play with wobble parameters
#    -S6A_RingSize=0.316 \
#    -S6A_NumRings=2 \

# To save the acceptance curve
#    -saveAcceptance \
#    -S6A_AcceptanceLookup=${LOGFILE}_Acc.root \

# From last MILSS attempt
#    -RBM_SearchWindowSqCut=0.1 \
#    -RBM_RingLowerRadius=0.8 \
#    -RBM_RingUpperRadius=1.2 \
#    -RBM_HistoBinSizeInDegrees=0.05 \
#    -RBM_HistogramSizeXAxis=6 \
#    -RBM_HistogramSizeYAxis=6 \
#    -RBM_HistogramWindowRadius=3 \
#    -RBM_ToleranceRadius=6 \
#    -S6A_SuppressWobble=1 \
#    -SM_FoVRadius=3    \
#    -S6A_TestPositionRA=287.02 \
#    -S6A_TestPositionDEC=6.32 \

# To exclude stars
#    -S6A_ExcludeStars=1 -S6A_ExclusionList=IC443/stars.dat \

# An example
#vaStage6 -S6A_ConfigDir=IC443/ -S6A_OutputFileName=res_ic443hs_0211_3 -S6A_ExcludeStars=1 -S6A_ExclusionList=IC443/stars.dat -S6A_TestPositionRA=94.22 -S6A_TestPositionDEC=22.55 -RBM_HistoBinSizeInDegrees=0.025 -RBM_PsiCut=1.7 -RBM_AccFitMax=2.89 -RBM_ToleranceRadius=6 -RBM_HistogramWindowRadius=3 -SM_FoVRadius=3 -saveAcceptance -S6A_AcceptanceLookup=ic443hs_0211_3_Acc.root -save_config=tmpv6_ic443hs_0211_3.cfg IC443/test-on-smoothed.txt 2>&1 | tee IC443/ic443hs_0211_3.log

# More options
#    -WA_UseGeneralizedLiMa=0 \
#    -EnergyLower=0 \
#    -CA_ThresholdMethod=0 \
#    -S6A_SuppressEventStats=0 \
#    -S6A_Spectrum=0 \
#    -SP_EnergyBinning=1 \
#    -S6A_LookupFileName=ea_zen1-50-SouthN050_2.root \
#    -S6A_SuppressWobble=0 \
#    -S6A_StereoParamDisplay=0 \
