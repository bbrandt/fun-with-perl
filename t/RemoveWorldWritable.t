# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl RemoveWorldWritable.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 3;
BEGIN { use_ok('RemoveWorldWritable') };

#########################

ok( defined($btaste) && ref $btaste eq 'Film',     'new() works' );
