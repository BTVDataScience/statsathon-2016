use strict;

my $sum = 0;

my $total = 174671;

while (<>) {
	next if /died/;
	chomp;
	my @comps = split(/\t/);
	my $died = $comps[-2];
	my $count = $comps[-1];
	my $p = $died / $count;
	if ($p > 0 && $p < 1) {
		$sum -= $count/$total * ($p * log($p) + (1-$p) * log(1-$p));
	}
}

print $sum / log(2), "\n";
