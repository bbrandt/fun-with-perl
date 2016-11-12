#!/usr/bin/perl -w

use strict;
use warnings;
use RemoveWorldWritable;
use Getopt::Long;

my $path   = Cwd::getcwd;
my $result = GetOptions ("path=s"   => \$path);

recursive_remove_world_writable($path);