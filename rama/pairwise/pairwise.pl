use strict;
use ConditionalEntropy;
use DBI;

my @features = ();
open(FEATURES, "features.txt") || die $!;
while (<FEATURES>) {
	chomp;
	push @features, $_;
}
close(FEATURES);

my $db = DBI->connect("dbi:mysql:statsathon:localhost", "nexus", "nexyou") || die $!;

$| = 1;

my $n = @features;

for (my $i=0; $i<$n; $i++) {
	for (my $j=0; $j<$n; $j++) {
		my $key1 = $features[$i];
		my $key2 = $features[$j];
		my $ent = ConditionalEntropy::forKeys($db, $key1, $key2);
		print "$key1\t$key2\t$ent\n";
	}
}
