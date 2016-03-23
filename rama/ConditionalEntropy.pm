package ConditionalEntropy;

use strict;
use DBI;

#my $totalrows = 174671;
my $totalrows = 139958; 

# select entropy(sum(died) / count(*)) from rawData;
# +-------------------------------+
# | entropy(sum(died) / count(*)) |
# +-------------------------------+
# |            0.2466629296541214 |
# +-------------------------------+

# select entropy(sum(died) / count(*)) from rawData where batch < 8;
# +-------------------------------+
# | entropy(sum(died) / count(*)) |
# +-------------------------------+
# |            0.2476288229227066 |
# +-------------------------------+


sub forKeys {
	my $db = shift;

	my @ais = @_;
	my $sels = join(",", @ais, "died");

	my $csr = $db->prepare("select $sels, count(*) from rawData where batch < 8 group by $sels order by $sels");
	$csr->execute;
	my $sum = 0;
	my $survivors = 0;
	while (my $row = $csr->fetch) {
		my @row = @$row;
		my $count = $row[-1];
		my $died = $row[-2];
		my $key = join("\t", @row[0 .. $#row-2]);
		if ($died == 0) {
			$survivors = $count;
		}
		else {
			my $totalkey = $count + $survivors;
			my $probkey = $totalkey / $totalrows;
			my $condent = conditional_entropy($count/$totalkey);
			$sum += $probkey * $condent;
			$survivors = 0;
		}
	}
	$csr->finish;
	return $sum;
}

sub conditional_entropy {
	my $p = shift;
	if ($p == 0 || $p == 1) {
		return 0;
	}
	return -($p * log($p) + (1-$p) * log(1-$p)) / log(2);
}

1;
