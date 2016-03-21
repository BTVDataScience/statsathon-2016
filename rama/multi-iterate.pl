use ConditionalEntropy;
use DBI;

my @soFar = ();
my %remaining = ();

open(FEATURES, "features.txt") || die $!;
while (<FEATURES>) {
	chomp;
	$remaining{$_} = 1;
}
close(FEATURES);

my $db = DBI->connect("dbi:mysql:statsathon:localhost", "nexus", "nexyou") || die $!;

my $n = shift @ARGV;

$| = 1;

while(<>) {
	print;
	chomp;
	my ($id, $entropy) = split(/\t/);
	push @soFar, $id;
	delete $remaining{$id};
}

for (my $j=0; $j<$n; $j++) {

	my $bestEnt = 1.0;
	my $bestId;
	foreach my $id (keys %remaining) {
		my $ent = ConditionalEntropy::forKeys($db, @soFar, $id);
		if ($ent < $bestEnt) {
			$bestEnt = $ent;
			$bestId = $id;
		}
	}

	push @soFar, $bestId;
	delete $remaining{$bestId};
	print "$bestId\t$bestEnt\n";
}


