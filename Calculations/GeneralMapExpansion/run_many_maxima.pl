#!/usr/bin/perl
$maxn = $ARGV[0];
$first = 3;
if($maxn > 95) { $first = 95; }
foreach $i ($first..$maxn) {
    print "$i : ";
    system("gen_xchr.pl $i");
    $n2 = $i;
    if($n2 < 10) { $n2 = "0$n2"; }
    $ifile = "tmp/xchr$n2\_out.txt";
    open(IN, $ifile) or die("Cannot read from $ifile");
    while($line = <IN>) {
	if($line =~ /%o13/) {
	    chomp($line);
	    @v = split(/\s+/, $line);
	    print(join(" ", @v[1..(@v-1)]), "\n");
	}
    }
    close(IN);
}
