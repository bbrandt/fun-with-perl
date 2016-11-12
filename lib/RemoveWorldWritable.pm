package RemoveWorldWritable;

use strict;
use warnings;
use Iterate;
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
	return (stat $_[0])[2] & S_IWOTH;
}

sub remove_world_writable {
	my $filePath = shift;
	chmod "o-w", $filePath;
}

sub recursive_remove_world_writable {
	my $start_dir = shift;
	  
	iterate 
		\&is_world_writable,
		\&remove_world_writable,
		$start_dir
}

=head1 AUTHOR

Ben Brandt <@BBrandtTX>

=cut

1;
