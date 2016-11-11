package RemoveWorldWritable;

use strict;
use warnings;
use Iterate;

our $VERSION = '1.00';
use base 'Exporter';

our @EXPORT = qw(recursive_remove_world_writable);

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

sub remove_world_writable {
	(stat $_[0])[2] & S_IWOTH	
}

sub recursive_remove_world_writable {
	my $start_dir = shift;
	  
	iterate 
		#sub { (stat $_[0])[2] & S_IWOTH },
		sub { return 1; },
		#sub { chmod o-w $_[0] }
		sub { print $_[0]; },
		$start_dir
}

=head1 AUTHOR

Ben Brandt <@BBrandtTX>

=cut

1;
