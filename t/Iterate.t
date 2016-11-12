# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Iterate.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use TestSetup;

use File::Spec;
use Test::More tests => 3;
BEGIN { use_ok('Iterate') };

#########################

# Arrange
my $dir = getcwd;
$testDir = File::Spec->catfile($dir, 't-iterate');
$aDir = File::Spec->catfile($testDir, 'a');
$bDir = File::Spec->catfile($testDir, 'b');
$cDir = File::Spec->catfile($bDir, 'c');

$file1 = File::Spec->catfile($aDir, 'f1');
$file2 = File::Spec->catfile($bDir, 'f2');
$file3 = File::Spec->catfile($cDir, 'f3');
$file4 = File::Spec->catfile($cDir, 'f4');

mkdir $testDir;
mkdir $aDir;
mkdir $bDir;
mkdir $cDir;

sub create_empty_file {
	eval {
		open my $fh, '>', $_[0]
		or die "Cannot create $_[0]: $!\n";
		close $fh or die "Cannot close $_[0]: $!\n";
	};
	return $@;
}

create_empty_file($file1);
create_empty_file($file2);
create_empty_file($file3);
create_empty_file($file4);

my @expected;
$expected[0] = $file1;
$expected[1] = $file2;
$expected[2] = $file4;

# Act
my @actual;
iterate 
	sub { /3$/ },
	sub { push @actual, $_ },
	$testDir

# Assert
is_deeply( [sort @actual, [sort @expected] );
