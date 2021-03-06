#!/usr/bin/perl

$ofile1 = "Maxima/onelocusA2_maxima.txt";
open(OUT1, ">$ofile1") or die("Cannot write to $ofile1");
$ofile2 = "R/onelocusA2.R";
open(OUT2, ">$ofile2") or die("Cannot write to $ofile2");
print OUT1 "/* one autosomal locus, 2-way RIL by sib mating */\n";
print OUT1 "/*  to load, use: batch(\"$ofile1\"); */\n\n";
print OUT2 "# one autosomal locus, 2-way RIL by sib mating\n\n";

$ofile3 = "Latex/onelocusA2_tables.tex";
open(OUT3, ">$ofile3") or die("Cannot write to $ofile3");
open(IN, "../.tex") or die("Cannot read from ../.tex");
while($line = <IN>) {
    push(@lines, $line);
}
foreach $i (0..(@lines-2)) {
    print OUT3 $lines[$i];
}
print OUT3 "\\textbf{\\sffamily One autosomal locus, 2-way RIL by sibling mating}\n\\bigskip\n\n";


print " -No. states\n";
$ifile = "Inputs/nstates.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT2 "# no. states\n";
while($line = <IN>) {
    chomp($line);
    ($prototype, $nstates) = split(/\s+/, $line);
    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    $nstates{$prototype} = $nstates;
}
close(IN);
    
print OUT1 "nstates : matrix([";
print OUT2 "nstates <- c(";

$flag = 0;
foreach $prototype (@prototypes) {
    if(!$flag) { $flag = 1; }
    else {
	print OUT2 ", ";
	print OUT1 ", ";
    }
    print OUT2 "\"$prototype\"=$nstates{$prototype}";
    print OUT1 "$nstates{$prototype}";
}
print OUT2 ")\n\n";
print OUT1 "])\$ /* no. states */\n\n";


print " -Starting dist'n\n";
$ifile = "Inputs/start.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT2 "# starting distribution\n";
@prototypes = ();
while($line = <IN>) {
    chomp($line);
    ($prototype, $pi0) = split(/\s+/, $line);
    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    $pi0{$prototype} = $pi0;
}
close(IN);
    
print OUT1 "pi0 : matrix([";
print OUT2 "pi0 <- c(";

$flag = 0;
foreach $prototype (@prototypes) {
    if(!$flag) { $flag = 1; }
    else {
	print OUT2 ", ";
	print OUT1 ", ";
    }
    print OUT2 "\"$prototype\"=$pi0{$prototype}";
    print OUT1 "$pi0{$prototype}";
}
print OUT2 ")\n\n";
print OUT1 "])\$  /* starting distribution */\n\n";


print " -Transition matrix\n";
$ifile = "Inputs/tm.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
$line = <IN>; chomp($line);
($junk, @colnames) = split(/\s+/, $line);
print OUT2 "# transition matrix\n";
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
    
print OUT1 "P : matrix(    /* transition matrix */\n";
$flag = 0;
foreach $prototype (@prototypes) {
    if(!$flag) { $flag = 1; }
    else { print OUT1 "],\n"; }
    print OUT1 "      [";
    foreach $i (0..(@colnames-1)) {
	if($i != 0) { print OUT1 ", "; }
	print OUT1 "$tm{$prototype}{$colnames[$i]}";
    }
}
print OUT1 "])\$\n\n";


print OUT2 "P <- \n    rbind(\n";
$flag = 0;
foreach $prototype (@prototypes) {
    if(!$flag) { $flag = 1; }
    else { print OUT2 "),\n"; }
    print OUT2 "      \"$prototype\"=c(";
    foreach $i (0..(@colnames-1)) {
	if($i != 0) { print OUT2 ", "; }
	print OUT2 "\"$colnames[$i]\"=$tm{$prototype}{$colnames[$i]}";
    }
}
print OUT2 "))\n\n";

print OUT3 "\\begin{center}\n";
print OUT3 "Transition matrix, \$\Pr(G_{k+1}=g_{k+1} | G_k = g_k)\$ \\\\[6pt]\n";
print OUT3 "\\renewcommand{\\arraystretch}{1.5}\\begin{tabular}{c";
foreach $i (0..(@colnames-1)) { print OUT3 "c"; }
print OUT3 "} \\hline\n";
$ncol = @colnames;
print OUT3 "& \\multicolumn{$ncol}{c}{\$g_{k+1}\$} \\\\ \\cline{2-";
print OUT3 $ncol+1;
print OUT3 "}\n";
print OUT3 "\$g_k\$ ";
foreach $cn (@colnames) { 
    $temp = $cn;
    $temp =~ s/x/ \\times /;
    print OUT3 "& \$$temp\$ ";
}
print OUT3 " \\\\ \\hline \n";
foreach $prototype (@prototypes) {
    $temp = $prototype;
    $temp =~ s/x/ \\times /;
    print OUT3 "\$$temp\$ ";
    foreach $cn (@colnames) {
	$junk = $tm{$prototype}{$cn};
	$junk =~ s/\*//g;
	print OUT3 "& \$$junk\$ ";
    }
    print OUT3 "\\\\ \n";
}
print OUT3 "\\hline\n";
print OUT3 "\\end{tabular}\n\\end{center}\n\n";


print " -kth generation probs\n";
$ifile = "Inputs/pi_k.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT2 "# kth generation probabilities\n";
@prototypes = ();
while($line = <IN>) {
    chomp($line);
    ($prototype, @pi_k) = split(/\s+/, $line);
    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    $pi_k{$prototype} = join(" ", @pi_k);
}
close(IN);
    
print OUT1 "pik : matrix([    /* kth generation probabilities */\n";
$flag = 0;
foreach $prototype (@prototypes) {
    if(!$flag) { $flag = 1; }
    else { print OUT1 ",\n"; }
    $temp = $pi_k{$prototype};
    $temp =~ s/{|\\{|\[/(/g;
    $temp =~ s/}|\\}|\]/)/g;
    print OUT1 "$temp";
}
print OUT1 "])\$\n\n";


print OUT2 "pik <- function(k)\n    c(\n";
$flag = 0;
foreach $prototype (@prototypes) {
    if(!$flag) { $flag = 1; }
    else { print OUT2 ",\n"; }
    print OUT2 "      \"$prototype\"=";
    $temp = $pi_k{$prototype};
    $temp =~ s/{|\\{|\[/(/g;
    $temp =~ s/}|\\}|\]/)/g;
    print OUT2 "$temp";
}
print OUT2 ")\n\n";


print OUT3 "\\clearpage\n\\begin{center}\n";
print OUT3 "Genotype probabilities at \$\\text{G}_2\\text{F}_k\$ ";
print OUT3 "(where \$\\text{G}_2\\text{F}_0 \\equiv AA \\times BB\$)\\\\[6pt]\n";
print OUT3 "\\renewcommand{\\arraystretch}{1.5}\\begin{tabular}{ccc}";
print OUT3 "\\hline\n";
print OUT3 "prototype & no. states & probability of each \\\\ \\hline\n";
foreach $prototype (@prototypes) {
    $temp = $prototype;
    $temp =~ s/x/ \\times /;
    print OUT3 "\$$temp\$ & $nstates{$prototype} & ";
    $junk = $pi_k{$prototype};
    $junk =~ s/\*//g;
    $junk =~ s/sqrt/\\sqrt/g;
    print OUT3 "\$$junk\$ \\\\ \n";
}
print OUT3 "\\hline\n";
print OUT3 "\\end{tabular}\n\\end{center}\n\n";



print OUT3 $lines[@lines-1];
