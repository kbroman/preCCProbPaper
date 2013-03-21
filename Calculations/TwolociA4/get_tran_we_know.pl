#!/usr/bin/perl
######################################################################
# find all known transitions, assuming we know everything up to some generation
######################################################################

$maxgen = $ARGV[0];
$pattern = $ARGV[1];
if($pattern eq "") { $pattern = "AA_AB"; }
if($pattern eq "AA_BB") {
    @starts = (1,7,2,3,6,8,5,11,12,13,14);
}
elsif($pattern eq "AA_AB") {
    @starts = (6,8,16,15);
}



if($maxgen < 2) { $maxgen = 4; }
@gen = (2..$maxgen);
foreach $start (@starts) {
    foreach $gen (@gen) {
	$tmpfile = "/tmp/junk";
	system("get_path.pl $start $gen $pattern > $tmpfile");
	open(IN, $tmpfile) or die("Cannot read from $tmpfile");
	while($line = <IN>) {
	    chomp($line);
	    $line =~ s/\s*//g;
	    if($line eq "") { next; }
	    @v = split(/:/, $line);
	    foreach $i (0..(@v-2)) {
		$known{$v[$i]}{$v[$i+1]} = 1;
	    }
	}
    }
}

foreach $key (sort numerically keys %known) {
    printf("%2d : ", $key);
    foreach $nextkey (sort numerically keys %{$known{$key}}) {
	printf("%2d ", $nextkey);
    }
    print "\n";
}


sub numerically { $a <=> $b; }
