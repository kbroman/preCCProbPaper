#!/usr/bin/perl
######################################################################
# get all paths from a given starting state to '1' that have a given length
######################################################################

$start = $ARGV[0];
$length = $ARGV[1];
($length > 1) or die("length must be >= 2.\n");
($length < 13) or die("length > 12 is probably too big.\n");

$pattern = $ARGV[2];
if($pattern eq "") { $pattern = "AA_AB"; }
if($pattern eq "AA_BB") {
    ($start > 0 and $start < 15) or die("start must be between 1 and 14\n");
}
elsif($pattern eq "AA_AB") {
    ($start > 0 and $start < 18) or die("start must be between 1 and 17\n");
}

$ifile = "$pattern\_matrix.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    $row = substr($v[0], 0, length($v[0])-1);
    shift @v;
    foreach $i (0..(@v/2 - 1)) {
	$tm{substr($v[2*$i], 0, length($v[2*$i])-1)}{$row} = 1;
    }
}

@newpaths = ($start);
foreach $k (2..$length) {
    @curpaths = @newpaths;
    @newpaths = ();
    foreach $path (@curpaths) {
	@x = split(/:/, $path);
	$last = $x[@x-1];
	foreach $newstate (keys %{$tm{$last}}) {
	    push(@newpaths, $path . ":" . $newstate);
	}
    }
}

foreach $path (sort bynumerpath @newpaths) {
    @x = split(/:/, $path);
    $last = $x[@x-1];
    if($last == 1) {
	foreach $i (0..(@x-2)) {
	    printf("%2d : ", $x[$i]);
	}
	printf("%2d\n", $x[$x-1]);
    }
}

sub bynumerpath {
    @a = split(/:/, $a);
    @b = split(/:/, $b);
    foreach $i (0..(@a-1)) {
	if($a[$i] != $b[$i]) {
	    return($a[$i] <=> $b[$i]);
	}
    }
    $a[0] <=> $b[0];
}
