#!/usr/bin/perl

$fromsub[0] = "left\\(";   $tosub[0] = "\\left(";
$fromsub[1] = "right\\)";   $tosub[1] = "\\right)";
$fromsub[2] = "left\\[";   $tosub[2] = "\\left[";
$fromsub[3] = "right\\]";   $tosub[3] = "\\right]";
$fromsub[4] = "\\*";    $tosub[4] = "";
$fromsub[5] = "sqrt";   $tosub[5] = "\\sqrt";
$fracsub = "frac\\[([^\]]+),([^\]]+)\\]";

$ofile1 = "Tables/onelocus_table.tex";
open(OUT1, ">$ofile1") or die("Cannot write to $ofile1");

print " -Autosome\n";
$ifile = "Calculations/OnelocusA4/Inputs/pi_k_ind.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    $nstates = $v[1];
    $prob = join(" ", @v[2..(@v-1)]);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    push(@nstates, $nstates);
    push(@prob, $prob);
    push(@chr, "A");
    push(@ind, "random");
}
close(IN);
    
print " -X chr female\n";
$ifile = "Calculations/OnelocusX4/Inputs/pi_k_female.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    $nstates = $v[1];
    $prob = join(" ", @v[2..(@v-1)]);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    push(@nstates, $nstates);
    push(@prob, $prob);
    push(@chr, "X");
    push(@ind, "female");
}
close(IN);
    
print " -X chr male\n";
$ifile = "Calculations/OnelocusX4/Inputs/pi_k_male.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    $nstates = $v[1];
    $prob = join(" ", @v[2..(@v-1)]);
    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    push(@nstates, $nstates);
    push(@prob, $prob);
    push(@chr, "X");
    push(@ind, "male");
}
close(IN);
    
print OUT1 "\\begin{center}\n";
print OUT1 "\\begin{tabular}{ccccc}";
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
print OUT1 "\\end{tabular}\n\\end{center}\n\n";

######################################################################


$ofile = "Tables/onelocus_autosome_tm_supp_table.tex";
open(OUT, ">$ofile") or die("Cannot write to $ofile");

print " -Autosome tm\n";
$ifile = "Calculations/OnelocusA4/Inputs/tm.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
$line = <IN>;
@states = ();
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $state = $v[0];
    if($state eq "") { next; }
    push(@states, $state);
    @{$prob{$state}} = @v[1..(@v-1)];
}
close(IN);

    
print OUT "\\begin{center}\n";
print OUT "\\begin{tabular}{rc\@{\\hspace{10mm}}";
foreach $state (@states) {
    print OUT "c";
}
print OUT "} \\hline\n";
$n = @states;
print OUT (" && \\multicolumn{", $n, "}{c}{\$g_{k+1}\$} \\\\ \\cline{3-", $n+2, "}\n");
print OUT "\\multicolumn{2}{c}{\$g_k\$} ";
foreach $i (1..(@states)) {
    print OUT " & $i";
}
print OUT "\\\\ \\hline\n";
foreach $i (0..(@states-1)) {
    $temp = $states[$i];
    $temp =~ s/x/ \\times /;
    print OUT ($i+1, ": & \$$temp\$ ");
    foreach $p (@{$prob{$states[$i]}}) {
	print OUT "& $p ";
    }
    print OUT "\\\\ \n";
}
print OUT "\\hline\n";
print OUT "\\end{tabular}\n\\end{center}\n\n";


######################################################################


$ofile = "Tables/onelocus_Xchr_tm_supp_table.tex";
open(OUT, ">$ofile") or die("Cannot write to $ofile");

print " -X chr tm\n";
$ifile = "Calculations/OnelocusX4/Inputs/tm.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
$line = <IN>;
@states = ();
%prob = ();
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $state = $v[0];
    if($state eq "") { next; }
    push(@states, $state);
    @{$prob{$state}} = @v[1..(@v-1)];
}
close(IN);

    
print OUT "\\begin{center}\n";
print OUT "\\begin{tabular}{rc\@{\\hspace{10mm}}";
foreach $state (@states) {
    print OUT "c";
}
print OUT "} \\hline\n";
$n = @states;
print OUT (" && \\multicolumn{", $n, "}{c}{\$g_{k+1}\$} \\\\ \\cline{3-", $n+2, "}\n");
print OUT "\\multicolumn{2}{c}{\$g_k\$} ";
foreach $i (1..(@states)) {
    print OUT " & $i";
}
print OUT "\\\\ \\hline\n";
foreach $i (0..(@states-1)) {
    $temp = $states[$i];
    $temp =~ s/x/ \\times /;
    print OUT ($i+1, ": & \$$temp\$ ");
    foreach $p (@{$prob{$states[$i]}}) {
	print OUT "& $p ";
    }
    print OUT "\\\\ \n";
}
print OUT "\\hline\n";
print OUT "\\end{tabular}\n\\end{center}\n\n";

######################################################################


$ofile = "Tables/onelocus_autosome_results_supp_table.tex";
open(OUT, ">$ofile") or die("Cannot write to $ofile");

print " -Autosome results\n";
$ifile = "Calculations/OnelocusA4/Inputs/nstates.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
%nstates = ();
while($line = <IN>) {
    chomp($line);
    ($prototype, $nstates) = split(/\s+/, $line);
    $nstates{$prototype} = $nstates;
}


$ifile = "Calculations/OnelocusA4/Inputs/pi_k_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
@prototypes = %prob = ();
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    $prob = join(" ", @v[1..(@v-1)]);

    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    $prob{$prototype} = $prob;
}
close(IN);

print OUT "\\begin{center} \\begin{tabular}{ccc} \\hline\n";
print OUT "Prototype & No. states & Probability of each \\\\ \\hline \n";
foreach $prototype (@prototypes) {
    $temp = $prototype;
    $temp =~ s/x/ \\times /;
    print OUT "\$$temp\$ & $nstates{$prototype} & \$$prob{$prototype}\$ \\\\ \n";
}
print OUT "\\hline\n";
print OUT "\\end{tabular}\n\\end{center}\n\n";


######################################################################


$ofile = "Tables/onelocus_Xchr_results_supp_table.tex";
open(OUT, ">$ofile") or die("Cannot write to $ofile");

print " -X chr results\n";
$ifile = "Calculations/OnelocusX4/Inputs/nstates.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
%nstates = ();
while($line = <IN>) {
    chomp($line);
    ($prototype, $nstates) = split(/\s+/, $line);
    $nstates{$prototype} = $nstates;
}


$ifile = "Calculations/OnelocusX4/Inputs/pi_k_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
@prototypes = %prob = ();
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    if($prototype eq "") { next; }
    push(@prototypes, $prototype);
    $prob = join(" ", @v[1..(@v-1)]);

    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
    }

    $prob{$prototype} = $prob;
}
close(IN);

print OUT "\\begin{center} \\begin{tabular}{ccc} \\hline\n";
print OUT "Prototype & No. states & Probability of each \\\\ \\hline \n";
foreach $prototype (@prototypes) {
    $temp = $prototype;
    $temp =~ s/x/ \\times /;
    print OUT "\$$temp\$ & $nstates{$prototype} & \$$prob{$prototype}\$ \\\\ \n";
}
print OUT "\\hline\n";
print OUT "\\end{tabular}\n\\end{center}\n\n";


