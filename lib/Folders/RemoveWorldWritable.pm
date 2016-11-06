package Files::RemoveWorldWritable;

use strict;
use warnings;
use Files::Iterate;

our $VERSION = '1.00';
use base 'Exporter';

our @EXPORT = qw(iterate);

=head1 NAME

Files::Iterate - Recursively iterate and processfiles 

=head1 SYNOPSIS

	use Files::Iterate;
	print iterate(file_selector, remove_global_writable);

=head1 DESCRIPTION

This is a procedural module which gives you the famous "Hello, world!"
message, and it’s even customizable!

=head2 Functions

The following functions are exported by default

=head3 iterate

		print iterate($file_selector, $file_operation);

=cut

# define the function iterate().

sub remove_world_writable {
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
