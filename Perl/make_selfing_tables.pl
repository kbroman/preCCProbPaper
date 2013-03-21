#!/usr/bin/perl

$fromsub[0] = "left\\(";   $tosub[0] = "\\left(";
$fromsub[1] = "right\\)";   $tosub[1] = "\\right)";
$fromsub[2] = "left\\[";   $tosub[2] = "\\left[";
$fromsub[3] = "right\\]";   $tosub[3] = "\\right]";
$fromsub[4] = "\\*";    $tosub[4] = "";
$fromsub[5] = "sqrt";   $tosub[5] = "\\sqrt";
$fracsub = "frac\\[([^\]]+),([^\]]+)\\]";

$ofile1 = "Tables/selfing_table.tex";
$ofile2 = "Tables/selfing_supp_table.tex";
open(OUT1, ">$ofile1") or die("Cannot write to $ofile1");
open(OUT2, ">$ofile2") or die("Cannot write to $ofile2");

print " -No. states\n";
$ifile = "Calculations/Selfing/Inputs/nstates.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    ($prototype, $nstates) = split(/\s+/, $line);
    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    $nstates{$prototype} = $nstates;
}
close(IN);
    
print " -Transition matrix\n";
$ifile = "Calculations/Selfing/Inputs/tm.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
$line = <IN>; chomp($line);
($junk, @colnames) = split(/\s+/, $line);
@prototypes = ();
while($line = <IN>) {
    chomp($line);
    ($prototype, @tm) = split(/\s+/, $line);
    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    foreach $i (0..(@colnames-1)) {
	$tm{$prototype}{$colnames[$i]} = $tm[$i];
    }
}
close(IN);
    
print OUT2 "\\begin{center}\n";
#print OUT2 "Transition matrix, \$\Pr(G_{k+1}=g_{k+1} | G_k = g_k)\$ \\\\[6pt]\n";
print OUT2 "{\\renewcommand{\\arraystretch}{1.5}\\begin{tabular}{c";
foreach $i (0..(@colnames-1)) { print OUT2 "c"; }
print OUT2 "} \\hline\n";
$ncol = @colnames;
print OUT2 "& \\multicolumn{$ncol}{c}{\$g_{k+1}\$} \\\\ \\cline{2-";
print OUT2 $ncol+1;
print OUT2 "}\n";
print OUT2 "\$g_k\$ ";
foreach $cn (@colnames) { 
    print OUT2 "& \$$cn\$ ";
}
print OUT2 " \\\\ \\hline \n";
foreach $prototype (@prototypes) {
    print OUT2 "\$$prototype\$ ";
    foreach $cn (@colnames) {
	$junk = $tm{$prototype}{$cn};
	$junk =~ s/\*//g;
	print OUT2 "& \$$junk\$ ";
    }
    print OUT2 "\\\\ \n";
}
print OUT2 "\\hline\n";
print OUT2 "\\end{tabular} }\n\\end{center}\n\n";


print " -kth generation probs\n";
$ifile = "Calculations/Selfing/Inputs/pi_k.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
@prototypes = ();
while($line = <IN>) {
    chomp($line);
    ($prototype, @pi_k) = split(/\s+/, $line);
    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    $prob = join(" ", @pi_k);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }
    
    $pi_k{$prototype} = $prob;
}
close(IN);
    

print OUT1 "\\begin{center}\n";
print OUT1 "\\renewcommand{\\arraystretch}{1.5}\\begin{tabular}{ccc}";
print OUT1 "\\hline\n";
print OUT1 "Prototype & No. states & Probability of each \\\\ \\hline\n";
foreach $prototype (@prototypes) {
    print OUT1 "\$$prototype\$ & $nstates{$prototype} & ";
    $junk = $pi_k{$prototype};
    print OUT1 "\$$junk\$ \\\\ \n";
}
print OUT1 "\\hline\n";
print OUT1 "\\end{tabular}\n\\end{center}\n\n";


