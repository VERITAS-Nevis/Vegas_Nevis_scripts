#!/usr/bin/perl -w

# Command-line arguments:
# 0 - file to download - will be written to current directory; just specify name
# 1 - directory to download from

$file = $ARGV[0];
$dir = $ARGV[1];
print "Getting ".$file." from ".$dir."\n";
$extra = " ";
if ( index($ENV{HOSTNAME}, "serret") != -1 ) {
    $extra=" -I /a/home/tehanu/humensky/.ssh/id_dsa_serret ";
}
$command="bbftp -m -p 6 -u bbftp -V -S ".$extra." -e".
    " \"get ".$dir."/".$file." ".$file."\" gamma1.astro.ucla.edu";
print $command."\n";
system $command;
