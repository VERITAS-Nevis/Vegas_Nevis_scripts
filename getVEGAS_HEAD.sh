# Nevis initialization
if [ -r ${NevisAppBase}/adm/nevis-init.sh ]; then
        . ${NevisAppBase}/adm/nevis-init.sh
fi

# User custom initialization
if [ -r ~/.myprofile ]; then
        . ~/.myprofile
fi

export HOME=/a/home/tehanu/gunes
#CVS
export CVSROOT=:pserver:gsenturk@romulus.ucsc.edu:/home/cvsuser/VERITAS
export CVS_RSH="ssh"

#ROOT
export ROOTSYS=$HOME/Programs/root
export PATH=$ROOTSYS/bin:$PATH
export LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH

export PATH=$PATH:/a/home/tehanu/gunes/Programs/mysql-4.1.22/bin:$HOME/Programs/veritas/VBF-0.3.1/bin:$HOME/Programs/boost_1_40_0/boost:$HOME/Programs/bin:$PATH
export LD_LIBRARY_PATH=$HOME/Programs/boost_1_40_0/boost:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$HOME/Programs/veritas/lib:$HOME/Programs/mysql-4.1.22/lib/mysql
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:$HOME/Programs/veritas/lib/pkgconfig

export VERITASBASE=$HOME/Programs/veritas
export PATH=$PATH:$VERITASBASE/include:$VERITASBASE/bin

cvs co -d last_nights_vegas_head -D "05/27/2013 03:05" -A vegas
#cvs co -d last_nights_vegas_head -A vegas
cd last_nights_vegas_head
cvs update -A -d
make clean 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make_clean.txt
make 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make.txt
make install 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make_install.txt
cd
grep "rror" /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make_error.txt
grep "arning" /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make_warning.txt
grep "rror" /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make_install.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_make_install_error.txt
export VEGAS=/a/home/tehanu/gunes/last_nights_vegas_head
#export VEGAS=/a/home/tehanu/errando/programs/veritas/src/vegas_v2-2-0/
export PATH=$PATH:$VEGAS/bin


mv /a/data/tehanu/gunes/vegas_monitoring/48931_last_nights_vegas_head_stage1_laser.txt /a/data/tehanu/gunes/vegas_monitoring/48931_night_before_vegas_head_stage1_laser.txt
mv /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage1.txt /a/data/tehanu/gunes/vegas_monitoring/48921_night_before_vegas_head_stage1.txt
mv /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage2.txt /a/data/tehanu/gunes/vegas_monitoring/48921_night_before_vegas_head_stage2.txt
mv /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage4.txt /a/data/tehanu/gunes/vegas_monitoring/48921_night_before_vegas_head_stage4.txt
mv /a/data/tehanu/gunes/vegas_monitoring/53296_last_nights_vegas_head_stage1_flasher.txt /a/data/tehanu/gunes/vegas_monitoring/53296_night_before_vegas_head_stage1_flasher.txt
mv /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage1.txt /a/data/tehanu/gunes/vegas_monitoring/53293_night_before_vegas_head_stage1.txt
mv /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage2.txt /a/data/tehanu/gunes/vegas_monitoring/53293_night_before_vegas_head_stage2.txt
mv /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage4.txt /a/data/tehanu/gunes/vegas_monitoring/53293_night_before_vegas_head_stage4.txt


vaStage1 -QSCTD_MinSumWinWidth=7 -QSCTD_MaxSumWinWidth=0 -BCI_TraceVarWindow=7 -Stage1_RunMode=laser /a/data/tehanu/gunes/data/laser/48931.cvbf /a/data/tehanu/gunes/vegas_monitoring/48931laser.root 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48931_last_nights_vegas_head_stage1_laser.txt
vaStage1 -QSCTD_MinSumWinWidth=7 -QSCTD_MaxSumWinWidth=0 -BCI_TraceVarWindow=7 -Stage1_RunMode=data /a/data/tehanu/gunes/data/crabForNightlyMonitoring/48921.cvbf /a/data/tehanu/gunes/vegas_monitoring/48921stage1.root 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage1.txt
cp /a/data/tehanu/gunes/vegas_monitoring/48921stage1.root /a/data/tehanu/gunes/vegas_monitoring/48921stage2.root
vaStage2 -TW_LowGainWindowWidth=7 -TW_HighGainWindowWidth=7 -BCI_TraceVarWindow=7 /a/data/tehanu/gunes/data/crabForNightlyMonitoring/48921.cvbf /a/data/tehanu/gunes/vegas_monitoring/48921stage2.root /a/data/tehanu/gunes/vegas_monitoring/48931laser.root 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage2.txt
cp /a/data/tehanu/gunes/vegas_monitoring/48921stage2.root /a/data/tehanu/gunes/vegas_monitoring/48921stage4.root
vaStage4.2 -cuts=/a/data/tehanu/gunes/cuts/stage4QualityCuts.txt -LTM_WindowSizeForNoise=7 -TelCombosToAllow=ALL -G_SimulationMode=0 -table=/a/data/tehanu/gunes/lookupTables/lt_Nov2010_na_ATM21_7samples_vegasv240rc1_allOffsets.root -OverrideLTCheck=1 /a/data/tehanu/gunes/vegas_monitoring/48921stage4.root 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage4.txt
#vaStage5 -cuts=/a/data/tehanu/gunes/cuts/stage5Cuts.txt -Method=stereo -RemoveCutEvents=1 -SaveDiagnostics=1 -inputFile=/a/data/tehanu/gunes/vegas_monitoring/48921stage4.root -outputFile=/a/data/tehanu/gunes/vegas_monitoring/48921stage5.root  2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_stage5.txt
#vaStage6 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/last_nights_vegas_head_stage6.txt


vaStage1 -QSCTD_MinSumWinWidth=7 -QSCTD_MaxSumWinWidth=0 -BCI_TraceVarWindow=7 -Stage1_RunMode=flasher /a/data/tehanu/gunes/data/flasher/53296.cvbf /a/data/tehanu/gunes/vegas_monitoring/53296flasher.root 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53296_last_nights_vegas_head_stage1_flasher.txt
vaStage1 -QSCTD_MinSumWinWidth=7 -QSCTD_MaxSumWinWidth=0 -BCI_TraceVarWindow=7 -Stage1_RunMode=data /a/data/tehanu/gunes/data/crabForNightlyMonitoring/53293.cvbf /a/data/tehanu/gunes/vegas_monitoring/53293stage1.root 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage1.txt
cp /a/data/tehanu/gunes/vegas_monitoring/53293stage1.root /a/data/tehanu/gunes/vegas_monitoring/53293stage2.root
vaStage2 -TW_LowGainWindowWidth=7 -TW_HighGainWindowWidth=7 -BCI_TraceVarWindow=7 /a/data/tehanu/gunes/data/crabForNightlyMonitoring/53293.cvbf /a/data/tehanu/gunes/vegas_monitoring/53293stage2.root /a/data/tehanu/gunes/vegas_monitoring/53296flasher.root 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage2.txt
cp /a/data/tehanu/gunes/vegas_monitoring/53293stage2.root /a/data/tehanu/gunes/vegas_monitoring/53293stage4.root
vaStage4.2 -cuts=/a/data/tehanu/gunes/cuts/stage4QualityCuts.txt -LTM_WindowSizeForNoise=7 -TelCombosToAllow=ALL -G_SimulationMode=0 -table=/a/data/tehanu/gunes/lookupTables/lt_Nov2010_na_ATM21_7samples_vegasv240rc1_allOffsets.root -OverrideLTCheck=1 /a/data/tehanu/gunes/vegas_monitoring/53293stage4.root 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage4.txt

diff /a/data/tehanu/gunes/vegas_monitoring/48931_last_nights_vegas_head_stage1_laser.txt /a/data/tehanu/gunes/vegas_monitoring/48931_night_before_vegas_head_stage1_laser.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48931_laser_stage1_diff.txt
diff /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage1.txt /a/data/tehanu/gunes/vegas_monitoring/48921_night_before_vegas_head_stage1.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_stage1_diff.txt
diff /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage2.txt /a/data/tehanu/gunes/vegas_monitoring/48921_night_before_vegas_head_stage2.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_stage2_diff.txt
diff /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage4.txt /a/data/tehanu/gunes/vegas_monitoring/48921_night_before_vegas_head_stage4.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_stage4_diff.txt

diff /a/data/tehanu/gunes/vegas_monitoring/53296_last_nights_vegas_head_stage1_flasher.txt /a/data/tehanu/gunes/vegas_monitoring/53296_night_before_vegas_head_stage1_flasher.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53296_flasher_stage1_diff.txt
diff /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage1.txt /a/data/tehanu/gunes/vegas_monitoring/53293_night_before_vegas_head_stage1.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_stage1_diff.txt
diff /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage2.txt /a/data/tehanu/gunes/vegas_monitoring/53293_night_before_vegas_head_stage2.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_stage2_diff.txt
diff /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage4.txt /a/data/tehanu/gunes/vegas_monitoring/53293_night_before_vegas_head_stage4.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_stage4_diff.txt

grep "rror" /a/data/tehanu/gunes/vegas_monitoring/48931_last_nights_vegas_head_stage1_laser.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48931_laser_stage1_error.txt
grep "rror" /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage1.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_stage1_error.txt
grep "rror" /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage2.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_stage2_error.txt
grep "rror" /a/data/tehanu/gunes/vegas_monitoring/48921_last_nights_vegas_head_stage4.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/48921_stage4_error.txt

grep "rror" /a/data/tehanu/gunes/vegas_monitoring/53296_last_nights_vegas_head_stage1_flasher.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53296_flasher_stage1_error.txt
grep "rror" /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage1.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_stage1_error.txt
grep "rror" /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage2.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_stage2_error.txt
grep "rror" /a/data/tehanu/gunes/vegas_monitoring/53293_last_nights_vegas_head_stage4.txt 2>&1 | tee /a/data/tehanu/gunes/vegas_monitoring/53293_stage4_error.txt
