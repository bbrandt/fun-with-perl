#!/usr/bin/perl -w

use strict;
use warnings;
use Fun::Files::Iterate;

iterate 
	'.', 
	#sub { (stat $_[0])[2] & S_IWOTH },
	sub { return 1; },
	#sub { chmod o-w $_[0] }
	sub { print $_[0]; }

