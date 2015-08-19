#!/usr/bin/perl -w
#use Getopt::Std;
#getopts("d:");
#if ( $opt_d ) {
#    $directory = "$opt_d";
#    print "Reading contents of ".$directory."\n";
#} else {
#    print "Need to specify a directory to read with -d\n";
#    exit;
#}
$directory = $ARGV[0];
print "Reading contents of ".$directory."\n";

$command="bbftp -m -p 1 -u bbftp -V -S -e \"dir ".$directory."\" gamma1.astro.ucla.edu";
print $command."\n";
system $command;
