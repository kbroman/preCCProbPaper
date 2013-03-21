#!/usr/bin/perl
######################################################################
# find all transitions that are new, in paths of a certain
# length from a given starting state (assuming we know all previous lengths)
######################################################################

$mystart = $ARGV[0];
$length = $ARGV[1];
($length > 1) or die("length must be >= 2.\n");
($length < 13) or die("length > 12 is probably too big.\n");

@starts = (6,12,13,18,16);
($mystart > 0 and $mystart < 19) or die("start must be between 1 and 18\n");

$maxgen = $length-1;
@gen = (2..$maxgen);
foreach $start (@starts) {
    foreach $gen (@gen) {
	$tmpfile = "/tmp/junk";
	system("get_path_AAAB.pl $start $gen > $tmpfile");
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

system("get_path_AAAB.pl $mystart $length > $tmpfile");
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
