#!/usr/bin/perl

$ifile1 = $ARGV[0]; # recursion matrix [not transposed and with all 0's]
$ifile2 = $ARGV[1]; # states (to become pictograms)
$ofile =  $ARGV[2];
$noindent = $ARGV[3];
open(IN, $ifile1) or die("Cannot read from $ifile1");
$line = <IN>;
$line = <IN>;
$nstates = 0;
while($line = <IN>) {
    @v = split(/\s+/, $line);
    $ncol = @v - 1;
    $state = $v[0];
    if($state eq "") { next; }
    @{$tran[$nstates]} = @v[1..(@v-1)];
    $nstates++;
}
close(IN);

open(IN, $ifile2) or die("Cannot read from $ifile2");
$line = <IN>;
while($line = <IN>) {
    @v = split(/\s+/, $line);
    $pattern[$v[0]-1] = $v[1];
}

open(OUT, ">$ofile") or die("Cannot write to $ofile");
print OUT "{ \\small \\renewcommand{\\arraystretch}{1.1}\n";
if($noindent eq "") {
    print OUT "\\begin{center}\n";
}
elsif($noindent eq "ni") {
    print OUT "\\noindent ";
}
print OUT "\\begin{tabular}{ccc";
foreach $i (1..$nstates) {
    print OUT "c";
}
print OUT "} \\hline\n";
print OUT " & & &";
print OUT "\\multicolumn{$nstates}{c}{State at \$k+1\$} \\\\\n";
print OUT ("\\cline{4-", $nstates+3, "}\n");
print OUT "\\multicolumn{2}{c}{State at \$k\$} & \n";
foreach $i (0..($nstates-1)) {
    print OUT ("& ", $i+1);
}
print OUT "\\\\ \\hline \n";

foreach $i (0..($nstates-1)) {
    print OUT ($i+1, " &\n");
    @pat = split(/\||x|/, $pattern[$i]);
    @toppat = @botpat = ();
    foreach $j (0..(@pat/2-1)) {
	push(@toppat, $pat[2*$j]);
	push(@botpat, $pat[2*$j+1]);
    }

    print OUT "{\\renewcommand{\\arraystretch}{0.3}\n";
    print OUT "\\renewcommand{\\tabcolsep}{0.5mm}\n";
    print OUT "\\parbox[b][3mm][c]{12mm}{\n";
    print OUT "\\begin{tabular}{|p{2mm}|p{2mm}||";
    foreach $j (2..(@botpat-1)) {
	print OUT "p{2mm}|";
    }
    print OUT "} \\hline\n";

    foreach $j (0..(@toppat-1)) {
	if($toppat[$j] eq "A") {
	    print OUT "\$\\bullet\$";
	}
	elsif($toppat[$j] eq "B") {
	    print OUT "\$\\circ  \$";
	}
	else {
	    print OUT "         ";
	}
	if($j < @toppat-1) { print OUT " & "; }
    }
    print OUT " \\\\\n";
    foreach $j (0..(@botpat-1)) {
	if($botpat[$j] eq "A") {
	    print OUT "\$\\bullet\$";
	}
	elsif($botpat[$j] eq "B") {
	    print OUT "\$\\circ  \$";
	}
	else {
	    print OUT "         ";
	}
	if($j < @botpat-1) { print OUT " & "; }
    } 
    print OUT " \\\\ \\hline\n";
    print OUT "\\end{tabular}}}\n";

    print OUT "&\n";
    $nprinted = 0;
    foreach $j (0..($nstates-1)) {
	print OUT ("& \$$tran[$i][$j]\$\n");
    }
    print OUT "\\\\\n";
}
print OUT "\\hline\n";
print OUT "\\end{tabular}\n";
if($noindent eq "") {
    print OUT "\\end{center} }\n";
}
else {
    print OUT "}\n";
}
