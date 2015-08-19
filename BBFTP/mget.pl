#!/usr/bin/perl -w

# Command-line arguments:
# 0 - destination directory - will be created if it doesn't exist.
# 1 - directory to download from

$dir2 = $ARGV[0];
$dir = $ARGV[1];

if ( ! -e $dir2 ) {
    mkdir $dir2, 0775 or die "Cannot make $dir2 directory: $!";
}
print "Getting ".$dir2." from ".$dir."\n";
$command="bbftp -m -p 6 -u bbftp -V -S -e \"mget ".
    $dir."/* ".$dir2."\" gamma1.astro.ucla.edu";
print $command."\n";
system $command;
