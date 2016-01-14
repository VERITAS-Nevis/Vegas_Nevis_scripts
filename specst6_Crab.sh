#!/bin/bash

cd /a/home/tehanu/dribeiro/Analysis/
vroot=/a/home/tehanu/ap3115/software/veritas/vegas-v2_5_4

if [ "$HOSTNAME" = "tehanu.nevis.columbia.edu" ]
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

echo "runst6.sh starting"
echo "   Running on "$HOSTNAME
echo "   Starting at " $( date )
echo "   Using vegas version in "$vroot
echo
echo

$vroot/bin/vaStage6 \
    -OverrideEACheck=1   -S6A_Batch=1 \
    -EA_UpdateModifiedEffectiveArea=0 -EA_RealSpectralIndex=-2.4 \
    -EA_WindowSizeForNoise=7 \
    -S6A_ReadFromStage4=true -S6A_ReadFromStage5Combined=1 \
    -S6A_Spectrum=0 \
    -S6A_UpperLimit=0 \
    -SP_EnergyBinning=4 \
    -SP_ForceFitRange=0 \
    -SP_SpectrumFitFunc=POWERLAW \
    -SP_IntegralFluxEmin=0.2 \
    -S6A_ConfigDir=$CONFDIR -S6A_OutputFileName=res_$LOGFILE \
    -S6A_ExcludeSource=1 -S6A_SourceExclusionRadius=0.4 \
    -S6A_StarExclusionBMagLimit=6 \
    -TelCombosToDeny=ANY2 \
    -S6A_StarExclusionRadius=0 \
    -S6A_NumRings=0 \
    -EC_maxPsiSq=2.89 \
    -S6A_DoRelativeExposure=0 \
    -S6A_SuppressRBMFinalStage=0 \
    -RBM_HistoBinSizeInDegrees=0.025 \
    -WA_UseGeneralizedLiMa=0 \
    -WA_Theta2HistNbins=400 \
    -S6A_DrawExclusionRegions=3 \
    -save_config=tmpv6_${LOGFILE}.cfg \
    -save_cuts=tmpv6_${LOGFILE}.cut \
    $RUNFILE 2>&1 | tee $CONFDIR/$LOGFILE.log

more tmpv6_${LOGFILE}.cfg >> $CONFDIR/$LOGFILE.log
rm tmpv6_${LOGFILE}.cfg
echo >> $CONFDIR/$LOGFILE.log
echo >> $CONFDIR/$LOGFILE.log
more tmpv6_${LOGFILE}.cut >> $CONFDIR/$LOGFILE.log
rm tmpv6_${LOGFILE}.cut
echo >> $CONFDIR/$LOGFILE.log
echo >> $CONFDIR/$LOGFILE.log
echo "Runlist used:" >> $CONFDIR/$LOGFILE.log
more $RUNFILE >> $CONFDIR/$LOGFILE.log

# -G_GlobalRandomSeed=<uint32_t=0>
#                            The is the seed for the random number generator
#                            (RNG). The default seed is "0", which means that RNG
#                            are initialized with random seeds (based on CPU
#                            time...).
# -G_GlobalDebugLevel=<string=E_NODEBUG>
#                            This is the global debug level. Possible values are
#                            "E_NODEBUG", "E_INFO", "E_FULLDEBUG". The default
#                            value is "E_NODEBUG", i.e. unless the user specify a
#                            higher debug level for specific classes, there will
#                            be no debug information produced.
# -G_GlobalDebugStream=<string=std::cout>
#                            This is the global debug stream. The default value
#                            is "std::cout". Any other value is interpreted as a
#                            filename, and the debug information will be streamed
#                            to that file.
# -G_DebugOptions=<vector<pair<string,pair<string,string>>>="">
#                            This is a list of classes with specific debug levels
#                            and streams. If you want a class called
#                            "VASomeThing" to have a debug level of "E_INFO" and
#                            stream the output to a file named
#                            "myclassdebug.txt", the option should be
#                            "VASomeThing/E_INFO/myclassdebug.txt".
# -G_SimulationMode=<bool=0>
#                            False (or 0) for real data. True (or 1) for
#                            simulation.
# -G_DiscardOverflow=<bool=1>
#                            False (or 0) if we are to try patching events
#                            affected by overflow. Default to True (or 1).
# -G_GlobalProgressPrintFrequency=<uint32_t=10000>
#                            Frequency at which information is printed for
#                            events. The default value is set to 1000,
#                            i.e.,information is printed every 1000 events. A
#                            value of 0 should be interpreted as NO PRINTOUT. Any
#                            other non-negative value (XXXX) is interpreted as:
#                            print every XXXX events.
# -G_NumEventsToAnalyse=<uint32_t=0>
#                            Number of events to analyse. Default value is 0,
#                            which means all events will be processed. Any other
#                            positive integer is interpreted as an upper limit on
#                            the number of events to be processed.
# -G_EventToStartFrom=<uint32_t=0>
#                            Start analysing at this event, skip all previous
# -G_PointingOffsetX=<vector<pair<uint16_t,float>>="">
#                            comma separated list of pointing offsets [degrees]
#                            in camera X-plane. 1==T1, 2==T2, 3==T3, 4==T4. For
#                            example, to put an arbitrary 0.05 degree mispointing
#                            on T1 and a 0.1 degree mispointing on T2 do:
#                            -G_PointingOffsetX=1/0.05,2/0.1
# -G_PointingOffsetY=<vector<pair<uint16_t,float>>="">
#                            comma separated list of pointing offsets [degrees]
#                            in camera X-plane. 1==T1, 2==T2, 3==T3, 4==T4. For
#                            example, to put an arbitrary 0.1 degree mispointing
#                            on T1 and a 0.05 degree mispointing on T2 do:
#                            -G_PointingOffsetY=1/0.1,2/0.05
# -G_BadGPSClocks=<vector<pair<uint16_t,bool>>="">
#                            Use this option to set a GPS clock to be bad. For
#                            the Telescope GPS clocks, the format is 1==T1,
#                            2==T2, 3==T3, 4==T4. Thus to set the GPS clocks for
#                            T1 and T3 do -G_BadGPSClocks=1/true, 3/true. You can
#                            also set the L3 array trigger GPS clock to be bad.
#                            In this case, we the index 0 to represet L3. Thus to
#                            set the L3, T1 and T3 GPS clocks to be bad, do
#                            -G_BadGPSClocks=0/true, 1/true, 3/true. The order is
#                            not important. Generally if you are using this
#                            option in Stage1, you will need to use it in stage 2
#                            also. These settings will be saved to the run
#                            header.
# -G_SourceName=<string=undefined>
#                            You can specify a source name here, e.g. Crab. If
#                            there are no source co-ordinates in the run header,
#                            maybe because the database was not contacted in
#                            stage 1, or you are using simulations, then this can
#                            be used in conjunction with VASourceList to get the
#                            source co-ordinates for later stage analysis
# -RBM_SearchWindowSqCut=<double=0.0169>
#                            This is the squared angular radius [deg] of the
#                            ON-source searching window.
# -RBM_RingLowerRadius=<double=0.6>
#                            The inner angular radius [deg] of the background
#                            ring. This radius must be larger than the On-source
#                            radius.
# -RBM_RingUpperRadius=<double=0.8>
#                            This parameter defines the outer angular radius
#                            [deg] of the background ring. Be aware than this
#                            radius has to be at least by one bin size (~0.1 deg)
#                            larger than the inner radius of the ring. At the
#                            same time it should not exceed the null limit of the
#                            acceptance, which is about 1.5 deg.
# -RBM_HistoBinSizeInDegrees=<double=0.025>
#                            This is the angular size of a bin in the 2D sky maps
#                            of a number of the On-source counts.
# -RBM_HistogramSizeXAxis=<double=6>
#                            The angular size of the 2d histogram along X-axis.
# -RBM_HistogramSizeYAxis=<double=6>
#                            The angular size of the 2d histogram along Y-axis.
# -RBM_ThetaSqNumBins=<int32_t=4000>
#                            The number of bins used for the theta2 plot for both
#                            signal and background histograms.
# -RBM_ThetaSqMax=<double=4>
#                            The upper bound in the theta2 plot [deg].
# -RBM_ToleranceRadius=<double=3>
#                            The angular radius of the scan window around the
#                            source. It is a priori defined parameter for a given
#                            acceptance.
# -RBM_PsiCut=<double=1.7>   The maximum angular distance from the tracking
#                            position to the reconstructed arrival direction.
#                            Units are deg.
# -RBM_NumPsiBins=<int32_t=29>
#                            The number of the bins used for the Acceptance plot
# -RBM_AccFitMin=<double=0>  The squared angular distance from the tracking
#                            position used as the lower bound of the fitting
#                            range for the acceptance curve. Not clear there's
#                            ever a reason to set this to a nonzero value. Units
#                            are deg^2
# -RBM_AccFitMax=<double=2.89>
#                            The squared angular distance from the tracking
#                            position used as the upper bound of the fitting
#                            range for the acceptance curve. This parameter is
#                            linked to RBM_PsiCut - if you define a cut on Psi
#                            that when squared is looser than this parameter,
#                            then the Psi cut is reset to the square root of
#                            AccFitMax. Units are deg^2.
# -RBM_AccFitFunction=<string=SMOOTH>
#                            This is the name of function used to fit the
#                            acceptance 1d plot. Options available are
#                            'POLYNOM4', 'PLEXP', and 'SMOOTH'. If you choose
#                            'SMOOTH', no fit is done - the acceptance plot is
#                            smoothed and used as-is.
# -RBM_AccSmoothingCycles=<int32_t=4>
#                            If you selected RBM_AccFitFunction=SMOOTH, use this
#                            flag to define how many times smoothing is applied.
# -RBM_MinNumberOnCounts=<int32_t=0>
#                            Minimum number of On counts required in a bin to
#                            fill that bin with a nonzero value in the sky maps.
# -RBM_MinNumberOffCounts=<int32_t=0>
#                            Minimum number of Off counts required in a bin to
#                            fill that bin with a nonzero value in the sky maps.
# -RBM_MinAlpha=<double=0.01>
#                            Minimum value of Alpha for which the sky map bins
#                            will be filled - the reciprocal of this value is
#                            also used as the maximum value of Alpha for which
#                            bins will be filled.
# -RBM_SigDistributionXmin=<double=-6>
#                            Low edge of histograms showing significance
#                            distributions.
# -RBM_SigDistributionXmax=<double=10>
#                            High edge of histograms showing significance
#                            distributions.
# -RBM_SigDistributionNbins=<int32_t=321>
#                            Number of bins in significance distributions.
# -RBM_CoordinateMode=<string=J2000>
#                            Use either J2000 or Galactic coordinates to fill the
#                            maps in the RBM analysis.
# -WA_UseGeneralizedLiMa=<bool=1>
#                            This flag determines how runs are combined when
#                            alpha differs between runs - set flag to false (0)
#                            to weight runs by their relative exposure; set flag
#                            to true (1) to use the Generalized Li&Ma equation.
#                            Default is to use the generalized Li&Ma equation for
#                            now - will change once the relative exposure code is
#                            better tested.
# -PSR_UseTempo2=<bool=1>    If true a file for input for the tempo timing
#                            package is written into the Stage6 output directory.
#                            and tempo is used for the barycentering of the event
#                            arrival times(requires that tempo2 is installed in
#                            the
#                            system)http://www.atnf.csiro.au/research/pulsar/tempo2/
# -PSR_Tempo2ParFile=<string="">
#                            This specifies the parameter file that tempo2 needs
#                            to do the barycentering.
# -PSR_EphemerisFileName=<string="">
#                            This specifies the name of the ephemeris file needed
#                            to do the Pulsar analysis.
# -PSR_PulsarName=<string=PSRB0531+21>
#                            This specifies the name of the Pulsar being
#                            Analyzed.
# -PSR_PhaseogramBins=<int32_t=11>
#                            Give the number of bins you would like to have for
#                            thephaseogram here.
# -PSR_OffPhaseRegions=<string=0.43 0.94>
#                            Give the boundaries for the off regions heree.g.
#                            "0.3 0.4 0.5 0.7" will set the off regions inunits
#                            of the pulsar phase from 0.3 to 0.4 and 0.5 to 0.7
# -PSR_OnPhaseRegions=<string=0.0 0.04 0.32 0.43 0.94 1.0>
#                            Give the boundaries for the on regions heree.g. "0.0
#                            0.1 0.8 0.9" will set the on regions inunits of the
#                            pulsar phase from 0.0 to 0.1 and 0.8 to 0.9
# -PSR_EventsPerStepInSignalGrowthPlots=<int32_t=1000>
#                            Give the number of events you want to increment
#                            between calculating the number of excess events and
#                            significance default is 1000
# -PSR_UseTempo2Phase=<bool=0>
#                            If true the phase from tempo2 is used in the pulsar
#                            analysis. If false the phase folding is done in
#                            tempo2
# -ThetaSquareLower=<double=0>
#                            Lower limit for the theta-square cut. Only used in
#                            MakeEA and vaStage5. Not used in vaStage6. Units are
#                            degrees^2. [def. 0]
# -ThetaSquareUpper=<double=129600>
#                            Upper limit for the theta-square cut. Explicitly NOT
#                            used in vaStage6 (even though its listed in the cuts
#                            file produced by vaStage6). This cut can and should
#                            only be used with makeEA (makeEffectiveArea) and it
#                            will be used by default in vaStage5 where you
#                            probably want to set it large (the default value
#                            should be good enough) so that it is ineffectual.
#                            For Stage6 you should use the parameters associated
#                            with each background model: -RBM_SearchWindowSqCut
#                            (for RBM) and -S6A_RingSize (for Wobble/reflected
#                            area model). Note that when generating spectra in
#                            vaStage6 a check is made comparing the
#                            ThetaSquareUpper value used to generate the
#                            Effective Area File (with makeEA) and the value of
#                            S6A_RingSize used in the spectral analyis (which
#                            uses the reflected area model). Units for
#                            ThetaSquareUpper are degrees^2. [def. 129600]
# -ImpactDistanceLower=<double=0>
#                            Lower limit for the Impact Distance. Units are m.
#                            [def. 0]
# -ImpactDistanceUpper=<double=1200>
#                            Upper limit for the Impact Distance. Units are m.
#                            [def. 1200]
# -MeanScaledWidthLower=<double=0>
#                            Lower limit for the Mean Scaled Width. Units are
#                            arbitrary. [def. 0]
# -MeanScaledWidthUpper=<double=10>
#                            Upper limit for the Mean Scaled Width. Units are
#                            arbitrary. [def. 10]
# -MeanScaledWidthSigmaLower=<double=0>
#                            Currently Unused. Lower limit for the Standard
#                            Deviation of the Mean Scaled Width. Units are
#                            arbitrary. [def. 0]
# -MeanScaledWidthSigmaUpper=<double=10>
#                            Currently Unused. Upper limit for the Standard
#                            Deviation of the Mean Scaled Width. Units are
#                            arbitrary. [def. 10]
# -MeanScaledLengthLower=<double=0>
#                            Lower limit for the Mean Scaled Length. Units are
#                            arbitrary. [def. 0]
# -MeanScaledLengthUpper=<double=10>
#                            Upper limit for the Mean Scaled Length. Units are
#                            arbitrary. [def. 10]
# -MeanScaledLengthSigmaLower=<double=0>
#                            Currently Unused. Lower limit for the Standard
#                            Deviation of the Mean Scaled Length. Units are
#                            arbitrary. [def. 0]
# -MeanScaledLengthSigmaUpper=<double=10>
#                            Currently Unused. Upper limit for the Standard
#                            Deviation of the Mean Scaled Length. Units are
#                            arbitrary. [def. 10]
# -MeanReducedScaledWidthLower=<double=-10>
#                            Lower limit for the Mean Reduced Scaled Width. Units
#                            are arbitrary. [def. -10]
# -MeanReducedScaledWidthUpper=<double=10>
#                            Upper limit for the Mean Reduced Scaled Width. Units
#                            are arbitrary. [def. 10]
# -MeanReducedScaledWidthSigmaLower=<double=0>
#                            Currently Unused. Lower limit for the Standard
#                            Deviation of the Mean Reduced Scaled Width. Units
#                            are arbitrary. [def. 0]
# -MeanReducedScaledWidthSigmaUpper=<double=10>
#                            Currently Unused. Upper limit for the Standard
#                            Deviation of the Mean Reduced Scaled Width. Units
#                            are arbitrary. [def. 10]
# -MeanReducedScaledLengthLower=<double=-10>
#                            Lower limit for the Mean Reduced Scaled Length.
#                            Units are arbitrary. [def. -10]
# -MeanReducedScaledLengthUpper=<double=10>
#                            Upper limit for the Mean Reduced Scaled Length.
#                            Units are arbitrary. [def. 10]
# -MeanReducedScaledLengthSigmaLower=<double=0>
#                            Currently Unused. Lower limit for the Standard
#                            Deviation of the Mean Reduced Scaled Length. Units
#                            are arbitrary. [def. 0]
# -MeanReducedScaledLengthSigmaUpper=<double=10>
#                            Currently Unused. Upper limit for the Standard
#                            Deviation of the Mean Reduced Scaled Length. Units
#                            are arbitrary. [def. 10]
# -MaxHeightLower=<double=-100>
#                            Lower limit for the Shower Maximum. Units are km.
#                            [def. -100]
# -MaxHeightUpper=<double=100>
#                            Upper limit for the Shower Maximum. Units are km.
#                            [def. 100]
# -MaxHeightSigmaLower=<double=-100>
#                            Currently Unused. Lower limit for the Standard
#                            Deviation of the Shower Maximum. Units are km. [def.
#                            -100]
# -MaxHeightSigmaUpper=<double=100>
#                            Currently Unused. Upper limit for the Standard
#                            Deviation of the Shower Maximum. Units are km. [def.
#                            100]
# -EnergyLower=<double=0>    Lower limit for the Energy. Units are GeV. [def. 0]
# -EnergyUpper=<double=100000>
#                            Upper limit for the Energy. Units are GeV. [def.
#                            100000]
# -EnergySigmaLower=<double=0>
#                            Currently Unused. Lower limit for the Standard
#                            Deviation of the Energy. Units are TeV. [def. 0]
# -EnergySigmaUpper=<double=10>
#                            Currently Unused. Upper limit for the Standard
#                            Deviation of the Energy. Units are TeV. [def. 10]
# -StdDirectionLower=<double=0>
#                            Lower limit for the Standard Deviation on the
#                            Direction. [def. 0]
# -StdDirectionUpper=<double=10>
#                            Upper limit for the Standard Deviation on the
#                            Direction. [def. 10]
# -StdCorePositionLower=<double=-500>
#                            Lower limit for the Standard Deviation on the Core
#                            Position. Units are m. [def. -500]
# -StdCorePositionUpper=<double=500>
#                            Upper limit for the Standard Deviation on the Core
#                            Position. Units are m. [def. 500]
# -BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score. BDT score ranges from
#                            -1 to 1. [def. -2 to ensure that if it is unused, it
#                            is obvious]
# -BDTScoreUpper=<double=1>  Upper limit for the BDT Score. BDT score ranges from
#                            -1 to 1. [def. 1]
# -Z10E1BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the first energy
#                            bin of the 10 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z10E1BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the first energy
#                            bin of the 10 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z10E2BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the second energy
#                            bin of the 10 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z10E2BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the second energy
#                            bin of the 10 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z10E3BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the third energy
#                            bin of the 10 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z10E3BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the third energy
#                            bin of the 10 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z10E4BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the fourth energy
#                            bin of the 10 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z10E4BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the fourth energy
#                            bin of the 10 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z20E1BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the first energy
#                            bin of the 20 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z20E1BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the first energy
#                            bin of the 20 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z20E2BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the second energy
#                            bin of the 20 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z20E2BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the second energy
#                            bin of the 20 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z20E3BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the third energy
#                            bin of the 20 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z20E3BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the third energy
#                            bin of the 20 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z20E4BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the fourth energy
#                            bin of the 20 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z20E4BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the fourth energy
#                            bin of the 20 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z30E1BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the first energy
#                            bin of the 30 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z30E1BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the first energy
#                            bin of the 30 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z30E2BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the second energy
#                            bin of the 30 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z30E2BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the second energy
#                            bin of the 30 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z30E3BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the third energy
#                            bin of the 30 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z30E3BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the third energy
#                            bin of the 30 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z30E4BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the fourth energy
#                            bin of the 30 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z30E4BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the fourth energy
#                            bin of the 30 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z40E1BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the first energy
#                            bin of the 40 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z40E1BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the first energy
#                            bin of the 40 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z40E2BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the second energy
#                            bin of the 40 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z40E2BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the second energy
#                            bin of the 40 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -Z40E3BDTScoreLower=<double=-2>
#                            Lower limit for the BDT Score of the third energy
#                            bin of the 40 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. -2]
# -Z40E3BDTScoreUpper=<double=1>
#                            Upper limit for the BDT Score of the third energy
#                            bin of the 40 degree zenith bin. BDT score ranges
#                            from -1 to 1. [def. 1]
# -DirRecSignalStatisticLower=<double=-100000>
#                            Lower limit for the signal to background resolving
#                            statistic that is output by direction reconstruction
#                            (e.g. disp-diff) [def. -100000]
# -DirRecSignalStatisticUpper=<double=100000>
#                            Upper limit for the signal to background resolving
#                            statistic that is output by direction reconstruction
#                            (e.g. disp-diff) [def. 100000]
# -TC_Algorithm2=<string=Method1>
# -SizeCombosToDeny=<vector<string>="">
#                            You can set which combinations of telescopes to
#                            allow/deny post cuts. By default 'ALL' combinations
#                            are allowed. This option lets you define
#                            combinations to deny; this option is overridden by
#                            its partner option -SizeCombosToAllow. If you want
#                            to specify your own combinations, you can set them
#                            using comma-separated options. Eg, if you want to
#                            cut T1T4 events but allow all others you can specify
#                            '-SizeCombosToDeny=T1T4'. Or, if you want to cut any
#                            event that includes T1 you can specify
#                            '-SizeCombosToDeny=T1T2,T1T3,T1T4,T1T2T3,T1T2T4,T1T3T4,T1T2T3T4.
#                            The input will also understand ANY2, ANY3, ANY4, and
#                            ALL. If you only want events that have all four
#                            telescopes, do -SizeCombosToDeny=ANY2,ANY3
# -SizeCombosToAllow=<vector<string>="">
#                            This option works in much the same way as
#                            -SizeCombosToDeny and takes the same type of string
#                            inputs. Combinations allowed using this option
#                            override combinations denied using
#                            -SizeCombosToDeny. For example, if you wanted to
#                            study T1T4 events, you might use the pair of options
#                            '-SizeCombosToDeny=ALL' and
#                            '-SizeCombosToAllow=T1T4'.
# -MinSize=<double=0>        This option takes a double specifying the minimum
#                            size value to be used in applying
#                            SizeCombosToDeny/SizeCombosToAllow
# -MinL2TriggeredTelescopes=<int32_t=2>
#                            This option takes an int and cuts any event with
#                            fewer L2 triggers
# -TC_Algorithm=<string=Method1>
# -TelCombosToDeny=<vector<string>="">
#                            You can set which combinations of telescopes to
#                            allow/deny post cuts. By default 'ALL' combinations
#                            are allowed. This option lets you define
#                            combinations to deny; this option is overridden by
#                            its partner option -TelCombosToAllow. If you want to
#                            specify your own combinations, you can set them
#                            using comma-separated options. Eg, if you want to
#                            cut T1T4 events but allow all others you can specify
#                            '-TelCombosToDeny=T1T4'. Or, if you want to cut any
#                            event that includes T1 you can specify
#                            '-TelCombosToDeny=T1T2,T1T3,T1T4,T1T2T3,T1T2T4,T1T3T4,T1T2T3T4.
#                            The input will also understand ANY2, ANY3, ANY4, and
#                            ALL. If you only want events that have all four
#                            telescopes, do -TelCombosToDeny=ANY2,ANY3
# -TelCombosToAllow=<vector<string>="">
#                            This option works in much the same way as
#                            -TelCombosToDeny and takes the same type of string
#                            inputs. Combinations allowed using this option
#                            override combinations denied using -TelCombosToDeny.
#                            For example, if you wanted to study T1T4 events, you
#                            might use the pair of options '-TelCombosToDeny=ALL'
#                            and '-TelCombosToAllow=T1T4'.
# -EC_AcceptanceLibrary=<string="">
#                            Name of root file containing the acceptance curve
#                            library to use. If not defined, exposure calculation
#                            will ignore acceptance corrections.
# -EC_minPsiSq=<double=0>    Minimum value of PsiSq to use in normalizing system
#                            acceptance to events collected in a single run.
#                            PsiSq is defined as the square of the distance
#                            between an event's reconstructed direction and the
#                            center of the Field of View.
# -EC_maxPsiSq=<double=2.25>
#                            Maximum value of PsiSq to use in normalizing system
#                            acceptance to events collected in a single run.
#                            PsiSq is defined as the square of the distance
#                            between an event's reconstructed direction and the
#                            center of the Field of View.
# -EA_SimulationType=<string=E_GrISU>
#                            Type of simulations used(E_KASCADE, E_ChiLA,
#                            E_GrISU)
# -EA_UseReconstructedEnergy=<bool=1>
#                            Set this to true to use the effective area curves
#                            made with the reconstructed energies (instead of MC
#                            energies)
# -EA_InterpolateInAzimuth=<bool=0>
#                            Set this to true to activate the interpolation in
#                            azimuth.
# -EA_SimSpectralIndex=<double=-2>
#                            Set this to the value of the spectral index used to
#                            generate the simsulations (e.g. -2.0). This has no
#                            effect on the KASCADE sims!
# -EA_RealSpectralIndex=<double=-2.5>
#                            Set this to the value of the best-estimated spectral
#                            index of the real source you are analyzing (e.g.
#                            -2.8). This is use to weight the simulations
# -EA_ModifyEffectiveArea=<bool=0>
#                            If true, modify the effective area vs reconstructed
#                            energy upon the spectral index during the EA
#                            production and not during stage 6. If false, do not
#                            modify the effective area during the effective area
#                            production but in stage6. Default is false.
# -EA_SafeEnergyRangeMethod=<string=E_EnergyEAPrecision>
#                            Specifies which method to use to calculate the safe
#                            energy range. The following methods are currently
#                            available: Standard (E_EnergyStandard, default),
#                            energy threshold calculated as the energy at the
#                            peak of the efficiency distribution, max energy as
#                            the last point where the effective area has a
#                            relative uncertainty <=0.5; Bias (E_EnergyBias) safe
#                            energy range calculated upon the maximum energy bias
#                            set in EA_MaxAllowedEnergyBias.
# -EA_MaxAllowedEnergyBias=<float=0.1>
#                            Set this to the value of the maximum allowed energy
#                            bias. Typically this is set to 10%. We use this
#                            value to determine the safe energy range.
# -EA_MaxEffectiveAreaUncertainty=<float=0.2>
#                            Set this to the value of the maximum allowed
#                            relative uncertainty of the effective area. It must
#                            be a value quadratically negligible with respect to
#                            the minimum statistical uncertainty required in each
#                            spectral point.Default is 0.2, good for 2 sigma
#                            minimum significance in each spectral point.
# -EA_WindowSizeForNoise=<uint32_t=7>
#                            Set the window size used for checking the camera
#                            noise when using noise in lookup tables.This
#                            **MUST** be the same when reading and writing the
#                            lookup tables
# -EA_SimThrowRadius_M=<float=750>
#                            Radius in meters over which simulated showers are
#                            thrown. Is ignored by KASCADE simulations.
# -EA_IsVolumeDetector=<bool=1>
#                            Specifies the geometry of the detectors assumed in
#                            the simulations: true for volume, false for flat. In
#                            Corsika, this corresponds to compiling with the
#                            VOLUMEDET option (true) or not (false), and
#                            determines whether the throw area requires a
#                            cos(zenith) scaling factor.
# -EA_UpdateModifiedEffectiveArea=<int32_t=1>
#                            Choose if you want to update the modified effective
#                            area (MEA) on-the-fly in Stage6. The
#                            EA_SimSpectralIndex and EA_RealSpectralIndex must be
#                            set to the appropriate values, otherwise you will
#                            get as a result a wrong MEA. There are three
#                            possible choices implemented: do not update the MEA
#                            (0), update with Glenn's algorithm (1, default),
#                            update with Nicola's algorithm (2).If you don't want
#                            to update the MEA on-the-fly, the MEA tables
#                            produced by the makeEA program will be used (if you
#                            specified makeEA to generate MEA's).
# -EA_DisableCheckEAModification=<bool=0>
#                            Disable a check on the EA modification. Effective
#                            areas modified in makeEA have a data member that
#                            tells the spectral index used for modification. A
#                            check on this data member enables or not the
#                            modification on the fly in stage6. Old effective
#                            area files do not carry this information, therefore
#                            if you decide not to modify on the fly in stage6 EAs
#                            from an old tables file (vegas<2.2.0), you should
#                            set this option to true. Default false.
# -WA_Theta2HistMinimum=<double=0>
#                            Set the minimum value of the wobble analysis theta
#                            square plot here
# -WA_Theta2HistMaximum=<double=4>
#                            Set the maximum value of the wobble analysis theta
#                            square plot here
# -WA_Theta2HistNbins=<int32_t=4000>
#                            Set the number of bins for the wobble analysis theta
#                            square plot here
# -HistoBinSizeInDegrees=<double=0.01>
#                            don't know what this does
# -HistogramSizeXAxis=<double=5>
#                            don't know what this does
# -HistogramSizeYAxis=<double=5>
#                            don't know what this does
# -HistogramCenterRA=<double=2.89923>
#                            don't know what this does
# -HistogramCenterDEC=<double=0.66687>
#                            don't know what this does
# -S6A_ConfigDir=<string=config>
#                            Here you should specify the configuration directory.
#                            If you want to save the configuration file by
#                            default you have to specify configuration directory
#                            first. All output files of stage 6 will be saved in
#                            this directory. It is strongly recommended that you
#                            create the configuration directory before running
#                            stage6 code.
# -S6A_OutputFileName=<string=results_>
#                            All histograms and plots will be saved into the
#                            output root file with this name. In addition, the
#                            plots will be printed into the postscript file with
#                            the same name too.
# -S6A_ObsMode=<string=Wobble>
#                            There are two observational mode used so far with
#                            VERITAS: On/Off and Wobble. If you chose the On/Off
#                            mode the run list should be composed in a sequence
#                            of On and Off runs, respectively. Select Wobble for
#                            all observations other than On/Off observations.
# -S6A_StereoParamDisplay=<bool=0>
#                            If you want to display a number of generic
#                            parameters used for the stereoscopic analysis e.g.
#                            mean scaled Width distribution of the impact
#                            distances etc, please set this key to true or 1.
# -S6A_CBGRingUpper=<double=-1>
#                            This defines the angular size of the upper ring used
#                            in the crescent background model.
# -S6A_CBGRingLower=<double=-1>
#                            This defines the angular size of the lower ring used
#                            in the crescent background model.
# -S6A_RingSize=<double=0.13>
#                            This defines the angular size of the regions used in
#                            the reflected region model. Note that this value is
#                            the square root of the quantity often referred to as
#                            theta squared
# -S6A_NumRings=<int32_t=0>  This defines the number of integration rings used in
#                            the reflected region model.
# -S6A_ExcludeStars=<bool=1>
#                            This defines whether star exclusion regions are
#                            used. Star exclusions are on (true) by default.
# -S6A_LookupFileName=<string="">
#                            For evaluation of the energy spectrum an auxilary
#                            file which contains the effective collection areas,
#                            is needed.This parameter defines the name of this
#                            file.
# -S6A_StarExclusionCatalog=<string="">
#                            By default, the Tycho catalog is used, and read from
#                            vegas/resultsExtractor/utilities. If you need to
#                            read a star catalog from a different file or
#                            location, use this flag to override the default
#                            location (should only need to do so under special
#                            circumstances, like using a distributed computing
#                            network). Note that this is for stars; for
#                            user-defined exclusions, use
#                            S6A_UserDefinedExclusionList.
# -S6A_StarCatFilterRadius=<double=3>
#                            Use this to choose the radius of stars to consider
#                            for exclusion regions. Set to <= 0 for NO RADIUS
#                            FILTERING. Default is 3.0 degrees.
# -S6A_DrawExclusionRegions=<int32_t=0>
#                            Use this to draw the exclusion regions on the
#                            skymaps. Options are: 0=none, 1=regions alone,
#                            2=stars alone, 3=both. Default is 0
# -S6A_ExcludeSource=<bool=0>
#                            This defines whether an exclusion region for the
#                            source is used - source taken from run header of
#                            first run, or assumed to be the TestPosition
#                            coordinates the the TestPositionRA and
#                            TestPositionDec flags are used. Set true to use
#                            exclusion region. Note: runs taken in Survey mode
#                            define the 'source' as the tracking direction so
#                            with them, this flag should only be used if you are
#                            also using the TestPosition flags. See also
#                            S6A_UserDefinedExclusionList.
# -S6A_StarExclusionRadius=<double=0>
#                            This is the radius of the STAR exclusion region in
#                            deg.If you set this, then ONE value is used for all
#                            stars, independent of magnitude. The default is a
#                            'smart' algorithm based on magnitude with 0.3 for
#                            most stars.
# -S6A_SourceExclusionRadius=<double=0.3>
#                            This is the radius of the SOURCE exclusion region in
#                            deg. The default 0.3 seems reasonable for moderately
#                            bright point sources; 0.4 better for Crab-strength
#                            point sources.
# -S6A_UserDefinedExclusionList=<string="">
#                            Here you define the filename of a list of sources
#                            that should be excluded from background estimation.
#                            Each row in the file defines one exclusion and
#                            requires four fields: RA and Dec in decimal degrees,
#                            radius of exclusion in degrees, and a name for the
#                            exclusion. A list of stars to exclude can be
#                            generated by using the S6A_ExcludeStars=true flag.
# -S6A_StarExclusionBMagLimit=<double=6>
#                            Sets the magnitude cutoff (B-band) used to generate
#                            a list of stars to exclude from a field.Note that
#                            the optimal value has not yet been carefully
#                            studied: the default is set to include stars of mag
#                            < 6.0 based on prior experience, but this may yield
#                            too many exclusions in galactic fields, for which a
#                            limit of 5.0 or 5.5 may be more appropriate. Be
#                            wary!
# -S6A_SuppressWobble=<bool=0>
#                            For some sky survey runs it makes sense to supress
#                            the final Wobble Analysis computations.
# -S6A_SuppressCBG=<bool=1>  Can now choose to run Crescent analysis instead of
#                            Wobble.
# -S6A_AcceptanceLookup=<string=VAAcceptanceLookupPlot.root>
#                            The radial acceptance plot can be saved or
#                            replaced.This is the name of the data file to which
#                            the acceptance is written or from which it is read,
#                            if either the saveAcceptance or loadAcceptance flags
#                            are set.
# -S6A_LoadAcceptance=<bool=0>
#                            Load acceptance curves. Goes with
#                            kAcceptanceLookup=true
# -S6A_SaveAcceptance=<bool=0>
#                            Save acceptance curves. Goes with
#                            kAcceptanceLookup=true
# -S6A_SuppressRBM=<bool=0>  Sometimes the RBM computations can take a lot of
#                            time.If you do not need these results, RBM can be
#                            turned off by setting this to true.
# -S6A_TestPositionRA=<double=0>
#                            Here you define the RA coordinate of the center of
#                            the sky maps defined in RBM, as well as the RA of
#                            the ON region for the Wobble Analysis. Be aware that
#                            the spectrum will be computed for this source then.
#                            Units are in degrees.
# -S6A_TestPositionDEC=<double=0>
#                            Here you define the DEC coordinate of the center of
#                            the sky maps defined in RBM, as well as the Dec of
#                            the ON region for the Wobble Analysis. Be aware that
#                            the spectrum will be computed for this source then.
#                            Units are in degrees.
# -S6A_SuppressRBMFinalStage=<bool=0>
#                            This flag suppresses only the final stage (map
#                            generation - the long part - of the Ring Background
#                            Model. Use this if you want to suppress the RBM map
#                            generation but plan to use the relative exposure
#                            corrections (kDoRelativeExposure=1)
# -S6A_SuppressRunStats=<bool=0>
#                            By default RunStats (runwise descriptive statistics
#                            are generated (0), but they can be suppressed by
#                            setting this flag to true (1).
# -S6A_SuppressEventStats=<bool=0>
#                            By default EventStats (limited eventwise statistics
#                            are not saved (1), but they can be saved in a root
#                            file by setting this flag to false (0).
# -S6A_Spectrum=<bool=0>     This defines whether the spectrum will be calculated
#                            or not. Select -true- if you want the spectrum to be
#                            calculated.
# -S6A_UpperLimit=<bool=0>   This defines whether an upper limit will be
#                            calculated or not. Select -true- if you want the
#                            upper limit to be calculated. This is independent on
#                            the spectrum, that means that you may calculate both
#                            a spectrum and an upper limit over the whole data
#                            set. This is NOT the option to set the calculation
#                            of an upper limit beyond the last significant
#                            spectrum point, use SP_UL instead.
# -S6A_BgEstimate=<string=wobble>
#                            This defines whether the spectrum will use the
#                            events selected by the RBM (ring), Wobble (wobble),
#                            or CBG (crescent) analysis (wobble, default).
# -S6A_LightCurve=<bool=0>   To generate the Light Curve please enable this key.
#                            Please remember that the right time sequence of the
#                            input data runs is important here! This light-curve
#                            code is currently broken; do not use.
# -S6A_PulsarAnl=<bool=0>    This flag allows you to do the Pulsar Analysis.
# -S6A_DoRelativeExposure=<bool=0>
#                            This flag enables calculation of relative exposure
#                            between runs, which takes care of weighting runs
#                            properly in wobble, light curve, spectrum when alpha
#                            varies between runs. Set to false by default while
#                            under development.
# -S6A_ReadFromStage4=<bool=0>
#                            Set to true if you want to read shower data directly
#                            from stage 4, without running stage 5. It is
#                            recommended that you do run stage 5, as the analysis
#                            is faster in the long run
# -S6A_ReadFromStage5Combined=<bool=0>
#                            Set to true if you want to read shower data and
#                            other information from the Stage5 combined tree This
#                            may become the recommended default
# -S6A_Batch=<bool=0>        Set this to true if you don't want any plots and
#                            want stage 6 to return to the command line upon
#                            completion. Useful for large batch jobs for eg
#                            optimisation
# -S6A_ApplyEnergyCorrection=<bool=0>
#                            Set this flag if you want to apply an energy scale
#                            correction. The formula to modify the energy scale
#                            is defined in S6A_EnergyCorrectionFormula option.
#                            Default false. ATTENZIONE!!!!! If you decide to
#                            modify the energy scale, your spectrum and upper
#                            limit will be modified accordingly, therefore will
#                            be written in the "IndecentResults" directory, in
#                            order to warn you that the result has been altered.
# -S6A_EnergyCorrectionFormula=<string=x>
#                            Set a string with the formula used to modify the
#                            energy scale. The format for the formula is the same
#                            as for a TFormula object. This option is ignored if
#                            S6A_ApplyEnergyCorrection is set to false. Default
#                            "x" (no modification of the energy scale).
# -SP_MinEnergy=<double=-1.5>
#                            Minimum energy for all spectral related histograms.
# -SP_MaxEnergy=<double=1.5>
#                            Maximum energy for all spectral related histograms.
# -SP_NumberOfBins=<int32_t=60>
#                            Number of bins for all spectral related histograms.
# -SP_EnergyBinning=<int32_t=4>
#                            For various signal to noise ratios you may consider
#                            fine or coarse bining of the final spectrum plot.
#                            This parameter could be set as e.g. 2,3,6.
# -SP_BinningFilename=<string="">
#                            Filename for list of energy bin low edges.
# -SP_ForceFitRange=<bool=0>
#                            Force the fitting range to what set by the user. If
#                            false, the fitting range is automatically resized to
#                            the (topologically) compact range of the spectrum.
#                            Default false.
# -SP_MinFitEnergy=<double=0.2>
#                            This is the low bound of energy range used for the
#                            energy spectrum fit.
# -SP_MaxFitEnergy=<double=5>
#                            This is the upper bound of energy range used for the
#                            energy spectrum fit.
# -SP_FitNormEnergy=<double=1>
#                            This is the normalization energy in TeV used to fit
#                            the spectrum. Default 1 TeV.
# -SP_TimeAcceptance=<double=0.1>
#                            Minimal fraction of total observing time for
#                            eachenergy bin.
# -SP_UL=<bool=0>            If set to 1, it computes an upper limit above the
#                            maximum energy of measured flux. Settings for the
#                            upper limit are imported from the UL_ resources. It
#                            overrides the settings for the energy range as it
#                            sets the energy range above the maximum flux energy.
# -SP_UpperLimitEnergy=<int32_t=0>
#                            Energy point where to calculate the differential
#                            upper limit: 0 central value of the first non
#                            significant Log10(E) bin (default), 1 mean energy of
#                            the non-significant energy range
# -SP_IntegralFluxEmin=<double=1>
#                            Specifies the lower-bound energy for the integral
#                            flux calculation.
# -SP_SpectrumAnlName=<string=Spectrum>
#                            Here you can set the name of this spectrum analysis
#                            run. It will show up in the name of the output root
#                            files.
# -SP_SpectrumFitFunc=<string=POWERLAW>
#                            Here you can define which function to use for the
#                            energy spectrumfit : current options are POWERLAW,
#                            CURVED (power law with an energy-dependent index),
#                            EXPCUTOFF (power law with an exponential cutoff) and
#                            CUSTOM. Default POWERLAW
# -SP_SpectrumCustomFitFunc=<string=[0]*TMath::Power(x,[1])>
#                            Here you can define your custom fit function. The
#                            function must be defined with TFormula format. This
#                            option is ignored if SP_SpectrumFitFunction is not
#                            set to CUSTOM. Default "[0]*TMath::Power(x,[1])"
# -SP_SpectrumCustomFuncInitParams=<vector<double>=4e-07,-2.5>
#                            Here you can initialize the parameters of your
#                            custom fit function. This is a comma-separated list
#                            ordered as your custom parameters. Default (two
#                            parameters in default custom function) 4e-7,-2.5
# -SP_MinSignificance=<double=2>
#                            This option defines the minimum statistical
#                            significance required in a bin to include it in the
#                            spectrum. Significance is calculated from On and Off
#                            counts and alpha via Li&Ma eqn 17. Default is 2.0
#                            sigma.
# -SP_MinExcess=<double=5>   This option defines the minimum excess required in a
#                            bin to include it in the spectrum. Excess is
#                            calculated from On and Off counts and alpha. Default
#                            is 5.0 counts.
# -SP_UseLaffertyWyattXEnergies=<bool=1>
#                            If true (default), calculates where to place data
#                            points along X axis following prescription of
#                            Lafferty & Wyatt, NIM A 355 (1995) 541-7.If false,
#                            uses mean energy within each bin to place points -
#                            more sensitive to fluctuations, can be pulled by CR
#                            spectrum.
# -UL_MinEnergy=<double=0>   Minimum energy above which to calculate the integral
#                            upper limit. If it is set to a lower value than the
#                            energy threshold, it is automatically reset to the
#                            energy threshold. Default value is the energy
#                            threshold.
# -UL_MaxEnergy=<double=30>  Maximum energy up to which to calculate the integral
#                            upper limit. Default value 30 TeV.
# -UL_EnergyThresholdMethod=<bool=1>
#                            Method to calculate the energy threshold. 0 - fit of
#                            efficiency plot with log-gaussian 1 - position of
#                            highest point in efficiency graph (default)
# -UL_ULMethod=<string=Rolke>
#                            Method to calculate the statistical upper limit.
#                            Available are: Rolke, FeldmanCousin, Helene. Default
#                            is Rolke.
# -UL_RolkeBounded=<bool=0>  If true, the Rolke upper limit will be calculated
#                            with bounded intervals. Defauld false (unbounded).
#                            If another method other than Rolke is used, this
#                            option is ignored.
# -UL_ConfidenceLevel=<double=0.99>
#                            Confidence level for the requested upper limit.
#                            Default is 0.99
# -UL_PhotonIndex=<double=-2.5>
#                            Photon index of the power law used to calculate the
#                            flux upper limit. Default is -2.5
# -UL_DifferentialEnergy=<double=0>
#                            Energy at which to calculate the differential upper
#                            limit. If it is lower than UL_MinEnergy, it is reset
#                            to that.
# -UL_Gamma1=<double=-2.5>   Photon index of the first power law used to
#                            calculate the decorrelation energy. Default -2.5
# -UL_Gamma2=<double=-3.5>   Photon index of the second power law used to
#                            calculate the decorrelation energy. Default -3.5
# -UL_Gamma3=<double=-4.5>   Photon index of the third power law used to
#                            calculate the decorrelation energy. Default -4.5
# -config=<string="">
# -save_config=<string="">
# -save_config_and_exit=<string="">
# -save_config_and_exit
# -save_config
# -config
# -cuts=<string="">          Load Cuts File
# -save_cuts=<string="">     Save a configuration file with all cuts values
#                            before processing.
# -save_cuts_and_exit=<string="">
#                            Save a configuration file with all cuts values and
#                            immediately exit.
