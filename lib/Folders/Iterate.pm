package Files::Iterate;

use strict;
use warnings;
use File::Find;

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
	my $file_selector = shift;
	my $file_operation = shift;
	my $start_dir = shift;
	  
	my @files;
	my $start_dir = ".";  # top level dir to search
	find( 
		sub { 
			unless (-d $File::Find::name)  {
				if ($file_selector($File::Find::name)) {
					push @files, $File::Find::name; 
				}
			}
		}, 
		$start_dir
	);

	for my $file (@files) {
		$file_operation($file); 
}

=head1 AUTHOR

Ben Brandt <@BBrandtTX>

=cut

1;
