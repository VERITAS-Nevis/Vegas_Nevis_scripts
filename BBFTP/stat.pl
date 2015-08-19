#!/usr/bin/perl -w

$file = $ARGV[0];
print "Getting stats for file ".$file."\n";
$command="bbftp -m -p 1 -u bbftp -V -S -e \"stat ".$file."\" gamma1.astro.ucla.edu";
print $command."\n";
system $command;
