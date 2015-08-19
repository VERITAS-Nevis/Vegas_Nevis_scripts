#!/usr/bin/perl -w

# Command-line arguments:
# 0 - path/directory to make

$file = $ARGV[0];
print "Making directory ".$file."\n";
$command="bbftp -m -p 6 -u bbftp -V -S -e \"mkdir ".
    $file."\" gamma1.astro.ucla.edu";
print $command."\n";
system $command;
