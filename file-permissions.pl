#!/usr/bin/perl -w

use strict;
use warnings;
use Iterate;
use File::stat;
use Fcntl ':mode';


print "Calling iterate";

sub is_world_writable {
	print "\nCheck world writable for: $_[0] \n";
	
	my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
			$atime,$mtime,$ctime,$blksize,$blocks)
		= stat($_[0]);	
	
	#my $st = stat($_[0]) or die "Can't stat $_[0]: $!";	
	
	my $other_write =  $mode & S_IWOTH;
	    
	#return $st->st_mode & S_IWOTH;
	#return (stat $_[0])[2] & S_IWOTH;
}

iterate(\&is_world_writable, sub { print "$_[0]\n"; }, "/media/sda2/src/cPanel-perl/t-permission"); 
