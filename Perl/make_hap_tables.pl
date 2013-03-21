#!/usr/bin/perl

$fromsub[0] = "left\\(";   $tosub[0] = "\\left(";
$fromsub[1] = "right\\)";   $tosub[1] = "\\right)";
$fromsub[2] = "left\\[";   $tosub[2] = "\\left[";
$fromsub[3] = "right\\]";   $tosub[3] = "\\right]";
$fromsub[4] = "\\*";    $tosub[4] = "";
$fromsub[5] = "sqrt";   $tosub[5] = "\\sqrt";
$fromsub[6] = "\\\\sqrt\\{r\\^2\\-10r\\+5\\}"; $tosub[6] = "t";
$fromsub6clean = "\\sqrt{r^2-10r+5}";
$fromsub[7] = "\\\\sqrt\\{4r\\^2\\-12r\\+5\\}"; $tosub[7] = "s";
$fromsub7clean = "\\sqrt{4r^2-12r+5}";
$fracsub = "frac\\[([^\]]+),([^\]]+)\\]";

$ofile1 = "Tables/haplotype_table.tex";
open(OUT1, ">$ofile1") or die("Cannot write to $ofile1");

print " -Autosome\n";
$ifile = "Calculations/TwolociA4/hap_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    if($prototype eq "") { next; }
    $nstates = $v[1];
    $nstates =~ s/\(|\)//g;
    $prob = join(" ", @v[2..(@v-1)]);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    push(@prototypes, $prototype);
    push(@nstates, $nstates);
    push(@prob, $prob);
    push(@chr, "A");
    push(@ind, "random");
}
close(IN);
    
print " -X chr female\n";
$ifile = "Calculations/TwolociX4/female_hap_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    if($prototype eq "") { next; }
    $nstates = $v[1];
    $nstates =~ s/\(|\)//g;
    $prob = join(" ", @v[2..(@v-1)]);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    push(@prototypes, $prototype);
    push(@nstates, $nstates);
    push(@prob, $prob);
    push(@chr, "X");
    push(@ind, "female");
}
close(IN);
    
print " -X chr male\n";
$ifile = "Calculations/TwolociX4/male_hap_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    if($prototype eq "") { next; }
    $nstates = $v[1];
    $nstates =~ s/\(|\)//g;
    $prob = join(" ", @v[2..(@v-1)]);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    push(@prototypes, $prototype);
    push(@nstates, $nstates);
    push(@prob, $prob);
    push(@chr, "X");
    push(@ind, "male");
}
close(IN);
    
print OUT1 "{\\footnotesize \n";
print OUT1 "\\renewcommand{\\arraystretch}{1.2}\\noindent\\begin{tabular}{ccccc}";
print OUT1 "\\hline\n";
print OUT1 "Chr. & Individual & Prototype & No. states & Probability of each \\\\ \\hline\n";
foreach $i (0..(@prototypes-1)) {
    if($i > 0 and $ind[$i] ne $ind[$i-1]) {
	print OUT1 "\\hline\n";
    }
    if($i == 0 || $ind[$i] ne $ind[$i-1]) {
	print OUT1 "$chr[$i] & $ind[$i] ";
    }
    else {
	print OUT1 " & ";
    }
    print OUT1 " & \$$prototypes[$i]\$ & $nstates[$i] & \$$prob[$i]\$ \\\\ \n";
}
print OUT1 "\\hline\n";
print OUT1 "\\end{tabular}\n\n";
print OUT1 "\\bigskip\nNote: \$$tosub[7] = $fromsub7clean\$ and \$$tosub[6] = $fromsub6clean\$;\n";
print OUT1 "the autosomal haplotype probabilities are valid for \$r < 1/2\$.\n";
print OUT1 "}\n\n";
