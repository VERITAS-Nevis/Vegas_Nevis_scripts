#!/usr/bin/perl -w

# Command-line arguments:
# 0 - file to upload - must be in current directory; just specify name
# 1 - directory to upload to

$file = $ARGV[0];
$dir = $ARGV[1];
print "Putting ".$file." into ".$dir."\n";
$command="bbftp -m -p 6 -u bbftp -V -S -e \"put ".
    $file." ".$dir."/".$file."\" gamma1.astro.ucla.edu";
print $command."\n";
system $command;
