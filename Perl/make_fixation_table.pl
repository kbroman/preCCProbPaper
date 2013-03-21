#!/usr/bin/perl

$ofile1 = "Tables/fixation_table.tex";
open(OUT1, ">$ofile1") or die("Cannot write to $ofile1");

$fromsub[0] = "left\\(";   $tosub[0] = "\\left(";
$fromsub[1] = "right\\)";   $tosub[1] = "\\right)";
$fromsub[2] = "left\\[";   $tosub[2] = "\\left[";
$fromsub[3] = "right\\]";   $tosub[3] = "\\right]";
$fromsub[4] = "\\*";    $tosub[4] = "";
$fromsub[5] = "sqrt";   $tosub[5] = "\\sqrt";
$fracsub = "frac\\[([^\]]+),([^\]]+)\\]";

print " -Autosome\n";
$ifile = "Calculations/OnelocusA4/Inputs/fixation.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $cross = $v[0];
    $chr = $v[1];
    $prob = join(" ", @v[2..(@v-1)]);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    if($cross eq "") { next; }
    push(@crosses, $cross);
    push(@chr, $chr);
    push(@prob, $prob);
}
close(IN);
    
print " -X chr\n";
$ifile = "Calculations/OnelocusX4/Inputs/fixation.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $cross = $v[0];
    $chr = $v[1];
    $prob = join(" ", @v[2..(@v-1)]);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    if($cross eq "") { next; }
    push(@crosses, $cross);
    push(@chr, $chr);
    push(@prob, $prob);
}
close(IN);
    
print OUT1 "{\\small \\begin{center}\n";
print OUT1 "\\renewcommand{\\arraystretch}{1.5}\\begin{tabular}{lcc}";
print OUT1 "\\hline\n";
print OUT1 "Cross & Chr & Probability of fixation at or before \$\\text{F}_k\$ \\\\ \\hline\n";
print OUT1 "Two-way selfing &   & \$1 - \\left(\\frac{1}{2}\\right)^{k-1}\$ \\\\ \n";

foreach $i (0..(@crosses-1)) {
    $crosses[$i] = (uc substr($crosses[$i], 0, 1)) . substr($crosses[$i], 1, length($crosses[$i]));
}

foreach $i (0..(@crosses-1)) {
    print OUT1 "$crosses[$i] sibling mating & $chr[$i]";

    print OUT1 "& \$$prob[$i]\$ \\\\ \n";
}
print OUT1 "\\hline\n";
print OUT1 "\\end{tabular}\n\\end{center} }\n\n";


