#! /usr/bin/perl 

use ConditionalEntropy;
use DBI;

my $db = DBI->connect("dbi:mysql:statsathon:localhost", "nexus", "nexyou") || die $!;

print ConditionalEntropy::forKeys($db, @ARGV), "\n";
