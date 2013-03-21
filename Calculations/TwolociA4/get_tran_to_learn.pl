#!/usr/bin/perl
######################################################################
# find all transitions that are new, in paths of a certain
# length from a given starting state (assuming we know all previous lengths)
######################################################################

$mystart = $ARGV[0];
$length = $ARGV[1];
($length > 1) or die("length must be >= 2.\n");
($length < 13) or die("length > 12 is probably too big.\n");

$pattern = $ARGV[2];
if($pattern eq "") { $pattern = "AA_AB"; }
if($pattern eq "AA_BB") {
    @starts = (1,7,2,3,6,8,5,11,12,13,14);
    ($mystart > 0 and $mystart < 15) or die("start must be between 1 and 14\n");
}
elsif($pattern eq "AA_AB") {
    @starts = (6,8,16,15);
    ($mystart > 0 and $mystart < 18) or die("start must be between 1 and 17\n");
}

$maxgen = $length-1;
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

system("get_path.pl $mystart $length $pattern > $tmpfile");
open(IN, $tmpfile) or die("Cannot read from $tmpfile");
while($line = <IN>) {
    chomp($line);
    $line =~ s/\s*//g;
    if($line eq "") { next; }
    @v = split(/:/, $line);
    foreach $i (0..(@v-2)) {
	unless($known{$v[$i]}{$v[$i+1]}) {
	    $unknown{$v[$i]}{$v[$i+1]} = 1;
	}
    }
}

foreach $key (sort numerically keys %unknown) {
    printf("%2d : ", $key);
    foreach $nextkey (sort numerically keys %{$unknown{$key}}) {
	printf("%2d ", $nextkey);
    }
    print "\n";
}

sub numerically { $a <=> $b; }
