#!/usr/bin/perl -w

use strict;
use warnings;
use RemoveWorldWritable;
use Getopt::Long;

my $path   = Cwd::getcwd;
my $user;
my $result = GetOptions ("path=s"   => \$path,
	"user=s"  => \$user);

my $uid   = getpwnam($user)  or die "cannot get id for user \n";

$> = $uid;

recursive_remove_world_writable($path);