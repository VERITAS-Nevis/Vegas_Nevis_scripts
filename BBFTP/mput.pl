#!/usr/bin/perl -w

# Command-line arguments:
# 0 - source directory
# 1 - destination directory

$dir = $ARGV[0];
$dir2 = $ARGV[1];
print "Putting ".$dir." in ".$dir2."\n";
$command="bbftp -m -p 6 -u bbftp -V -S -e \"mput ".
    $dir."/* ".$dir2."\" gamma1.astro.ucla.edu";
print $command."\n";
system $command;
