# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl RemoveWorldWritable.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use File::Spec;
use File::Path qw(remove_tree);
use Test::More tests => 4;
BEGIN { use_ok('RemoveWorldWritable') };

#########################

# Arrange
my $dir = Cwd::getcwd;
my $testDir = File::Spec->catfile($dir, 't-permission');
my $aDir = File::Spec->catfile($testDir, 'a');
my $bDir = File::Spec->catfile($testDir, 'b');
my $cDir = File::Spec->catfile($bDir, 'c');

my $file1 = File::Spec->catfile($aDir, 'f1');
my $file2 = File::Spec->catfile($bDir, 'f2');
my $file3 = File::Spec->catfile($cDir, 'f3');
my $file4 = File::Spec->catfile($cDir, 'f4');

remove_tree $testDir;

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

chmod 777, $file3;
chmod 777, $file2;

ok(is_world_writable($file3), "file3 world writable");
ok(is_world_writable($file2), "file2 world writable");

my @expected;
$expected[0] = $file1;
$expected[1] = $file2;
$expected[2] = $file4;

# Act
recursive_remove_world_writable 
	$testDir;

# Assert
ok(!is_world_writable($file3));
ok(!is_world_writable($file2));

remove_tree $testDir;
