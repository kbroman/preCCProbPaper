#!/usr/bin/perl

$ifile = $ARGV[0];
if($ifile eq "statesA8_rev.txt") {
    $ofile = "statesA8.R";
}
elsif($ifile eq "statesX8_rev.txt") { 
    $ofile = "statesX8.R";
}
else {
    die("invalid file\n");
}

open(OUT, ">$ofile") or die("Cannot write to $ofile");

open(IN, $ifile) or die("Cannot read from $ifile");
while($line = <IN>) {
    chomp($line);
    ($state,$count,$state4w, $prob) = split(/\s+/, $line);
    push(@states, $state);
    $count{$state} = $count;
    $state4w{$state} = $state4w;
    $prob{$state} = $prob;
}
print OUT "statesA8 <- function(r) {\n";
print OUT "result <- data.frame(\n";
print OUT "count=c(";
$flag = 0;
foreach $state (@states) {
    if(!$flag) { $flag = 1; }
    else { print OUT ","; }
    print OUT " $count{$state}";
}
print OUT "),\n";
print OUT "state4w=c(";
$flag = 0;
foreach $state (@states) {
    if(!$flag) { $flag = 1; }
    else { print OUT ","; }
    print OUT " \"$state4w{$state}\"";
}
print OUT "),\n";
print OUT "prob=c(";
$flag = 0;
foreach $state (@states) {
    if(!$flag) { $flag = 1; }
    else { print OUT ","; }
    $prob = $prob{$state};
    $fracsub = "frac\\[([^\]]+),([^\]]+)\\]";
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/(($1)\/($2))/;
    }

    print OUT " $prob";
}
print OUT "), stringsAsFactors=FALSE)\n";
print OUT "rownames(result) <- c(";
$flag = 0;
foreach $state (@states) {
    if(!$flag) { $flag = 1; }
    else { print OUT ", "; }
    print OUT " \"$state\"";
}
print OUT ")\nresult\n";
print OUT "}\n";


