#!/usr/bin/perl
# insert tables into preCCprob latex doc

$ifile = $ARGV[0];
@v = split(/_/, $ifile);
$ofile = join("_", @v[0..(@v-2)]) . ".tex";

open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile");
while($line = <IN>) {
    if($line =~ /KWBinsert/) {
	chomp($line);
	@v = split(/:/, $line);
	$file = $v[1];
	open(IN2, $file) or die("Cannot read from $file");
	while($line = <IN2>) {
	    print OUT $line;
	}
	close(IN2);
    }
    else { 
	print OUT $line;
    }
}
