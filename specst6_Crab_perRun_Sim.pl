#!/usr/bin/perl

$method=$ARGV[0];
#$stage=$ARGV[3];

#@epochs=("oa", "na", "ua");
@epochs=("ua");
#@wobbles=("000", "025", "050", "075", "100", "125", "150", "175", "200");
@wobbles=("000", "025", "050", "075", "100", "125", "150", "175", "200");
#@atms=("21", "22");
@atms=("21");
#@Zeniths=("00", "20", "30", "35", "40", "45", "50", "55", "60", "65");
@Zeniths=("20","45", "50", "55", "60", "65");
#@noises=("100", "150", "200", "250", "300", "350", "400", "490", "605", "730", "870");
@noises=("350", "400");

#$bin_range="_0_3_"
$bin_range="";

$bindir="/a/home/tehanu/dribeiro/Analysis/scripts";
$rundir="/a/home/tehanu/dribeiro/Analysis/CrabSim/runlists/stage6/PerRun";
$configdir="/a/home/tehanu/dribeiro/Analysis/CrabSim/stage6/PerRun";
$storage="/a/data/ged/dribeiro/CrabSim/2_5_4/Stage6files";

#$cuts=(soft hard med);
$cut="med-com";

foreach $epoch (@epochs)
{ 
  foreach $wobble (@wobbles)
  { 
    foreach $atm (@atms)
    {   
      foreach $zenith (@Zeniths)
      { 
        foreach $noise (@noises)
        { 
          $dataRun="Oct2012_".$epoch."_ATM".$atm."_vegasv250rc5_7samples_".$zenith."deg_".$wobble."wobb_".$noise."noise";
          $prefix=${dataRun}."-".${cut}."-".${method}.${bin_range};
          $st6runlist=${prefix}.".txt";
          $fullrunlist=${rundir}."/".${st6runlist};
          print "${bindir}/specst6_Crab.sh ${fullrunlist} ${storage}/ ${prefix}\n";
          }
        }
      }
    } 
  }

