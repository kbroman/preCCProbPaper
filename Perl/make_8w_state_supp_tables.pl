#!/usr/bin/perl
use POSIX;

$ifile = $ARGV[0]; # "Calculations/Eightway/statesA8_rev.txt";
$ofile = $ARGV[1]; # "Tables/statesA8_supp_table.tex";
$fracsub = "frac\\[([^\]]+),([^\]]+)\\]";

open(IN, $ifile) or die("Cannot read from $ifile");
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $state = $v[0];
    if($state eq "") { next; }
    if($ifile =~ /X/ and $v[3] eq "0") { next; }
    push(@states, $state);
    $count{$state} = $v[1];
    $state4w{$state} = $v[2];

    $prob = join(" ", @v[3..(@v-1)]);
    $prob =~ s/\*//g;
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    $prob{$state} = $prob;
}

open(OUT, ">$ofile") or die("Cannot write to $ofile");
print OUT "\\begin{center}\\begin{tabular}{ccccccccc}";
print OUT "\\cline{1-4} \\cline{6-9}\n";
print OUT "          &            & 4-way & Probability & &\n";
print OUT "          &            & 4-way & Probability \\\\[-6pt] \n";
print OUT "Prototype & No. states & state & multiplier & \\hspace{10mm} &\n";
print OUT "Prototype & No. states & state & multiplier \\\\ \\cline{1-4} \\cline{6-9}\n";

$n = @states;
$halfn = ceil(@states/2);


foreach $i (0..($halfn-1)) {
    $temp = lc $states[$i];
    print OUT "\$$temp\$ & $count{$states[$i]} & \$$state4w{$states[$i]}\$ & ";
    print OUT "\$$prob{$states[$i]}\$ ";
    print OUT "&&\n";
    if($halfn+$i < $n) {
	$temp = lc $states[$halfn+$i];
	print OUT "\$$temp\$ & $count{$states[$halfn+$i]} & \$$state4w{$states[$halfn+$i]}\$ & ";
	print OUT "\$$prob{$states[$halfn+$i]}\$ ";
    }
    else {
	print OUT "& & &"; 
	$rightdone = 1;
    }

    print OUT "\\\\ \n";

    if($halfn+$i == $n-1) {
	print OUT "\\cline{6-9}\n";
    }
}
print OUT "\\cline{1-4}";
unless($rightdone) {
 print OUT " \\cline{6-9} ";
}
print OUT "\n\\end{tabular} \\end{center}\n";
