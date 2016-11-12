package RemoveWorldWritable;

use strict;
use warnings;
use Iterate;
use File::Find;
use Fcntl ':mode';

our $VERSION = '1.00';
use base 'Exporter';

our @EXPORT = qw(is_world_writable remove_world_writable recursive_remove_world_writable);

=head1 NAME

RemoveWorldWritable - Recursively remove world writable permissions from files. 

=head1 SYNOPSIS

	use RemoveWorldWritable;
	recursive_remove_world_writable(start_dir);

=head1 DESCRIPTION

This is a procedural module which removes world writable permission from files.

=head2 Functions

The following functions are exported by default

=head3 recursive_remove_world_writable

		recursive_remove_world_writable($start_dir);

=cut

sub is_world_writable {
	my $filePath = shift;

	return (stat $filePath)[2] & S_IWOTH;
}

sub remove_world_writable {
	my $filePath = shift;

	my	$perm = (stat $filePath)[2];	
	
	chmod $perm & (~S_IWOTH & 0777), $filePath;
}

sub recursive_remove_world_writable_overly_complex {
	my $start_dir = shift;
	  
	iterate 
		\&is_world_writable,
		\&remove_world_writable,
		$start_dir
}

sub recursive_remove_world_writable {
	my $start_dir = shift;
	  
	my @files;
	print "\nStarting in directory: $start_dir\n"; 
	find( 
		sub { 
			print "Testing file: $File::Find::name \n";			
			unless (-d $File::Find::name)  {
				if (is_world_writable($File::Find::name)) {
					print "Adding file: $File::Find::name \n";				
					push @files, $File::Find::name; 
				}
				else {
					print "Excluding file: $File::Find::name \n"; 					
				}
			}
			else {
				print "Excluding directory: $File::Find::name \n"; 					
			}
		}, 
		$start_dir);

	for my $file (@files) {
		remove_world_writable($file); 
	}
}

=head1 AUTHOR

Ben Brandt <@BBrandtTX>

=cut

1;
