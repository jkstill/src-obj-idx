#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use IO::File;

my $DEBUG=0;

# tokens file created with get-all-tokens.sh
open TOKENS, '<', 'tokens-all.txt';
my @tokens = <TOKENS>;
chomp @tokens;
#my $matchStr=join('|',@tokens);
#print $matchStr;

# track 
my %objIdx=();

my $fileCount=0;

foreach my $srcFile ( qx/find Proc Table View -type f/ ) {

	chomp $srcFile;

	last if $DEBUG && $fileCount++ > 10;

	print "File: $srcFile\n";
	my @filenameParts = split(/\//, $srcFile);

	my $fh = IO::File->new();
	$fh->open($srcFile, O_RDONLY);
	die "Failed to open $srcFile - $!\n" unless $fh;
	my @lines=<$fh>;
	chomp @lines;
	#
	#print Dumper(\@lines);

	foreach my $token (@tokens) {
		#print "Token: $token\n";
		my @tokensFound = grep(/$token/,@lines);
		foreach my $tokenFound ( @tokensFound ) {
			$objIdx{$token}->{$srcFile}++;
		}
	}

}

print Dumper(\%objIdx) if $DEBUG;

my $fh = IO::File->new();
my $idxFile='schema-index.txt';
$fh->open($idxFile, O_CREAT|O_WRONLY) or die "Could not create $idxFile - $!\n";

print "Creating index...\n";

foreach my $token ( sort keys %objIdx ) {
	foreach my $file ( sort keys %{$objIdx{$token}} ) {
		print $fh "$token:$file\n";
	}
}


