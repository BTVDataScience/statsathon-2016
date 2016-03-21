use strict;

my @ais = qw(AIS140656 AIS140202 AIS160214 AIS140684 AIS140678 AIS140666 AIS140650 AIS442202 AIS150206 AIS140690 AIS140629 AIS140210 AIS150200 AIS140648);

for (my $n = 1; $n <=14; $n++) {
	print "update pValues set p_$n = (select sum(died) / count(*) from rawData where batch < 9";
	for ( my $i=0; $i<$n; $i++) {
		print " and pValues.$ais[$i] = rawData.$ais[$i]";
	}
	print ");\n\n";
}
