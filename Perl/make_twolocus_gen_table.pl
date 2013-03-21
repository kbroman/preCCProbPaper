#!/usr/bin/perl

$ifile1 = $ARGV[0]; # recursion matrix [transposed; only non-zero elements]
$ifile2 = $ARGV[1]; # states (to become pictograms)
$ofile =  $ARGV[2];
open(IN, $ifile1) or die("Cannot read from $ifile1");
$line = <IN>;
$nstates=0;
$maxncol=0;
while($line = <IN>) {
    @v = split(/\s+/, $line);
    $state = $v[0];
    $state =~ s/://;
    if($state eq "") { next; }
    $nstates++;
    $ncol = (@v-1)/2;
    if($ncol > $maxncol) { $maxncol = $ncol; }
    foreach $i (0..($ncol-1)) {
	$prevstate = $v[$i*2+1];
	$prevstate =~ s/://g;
	$prob = $v[$i*2+2];
	$prob =~ s/\*//g;
	if($prob =~ /\//) {
	    @x = split(/\//, $prob);
	    if($x[0] =~ /^\(/ and $x[0] =~ /\)$/) {
		$x[0] =~ s/^\(//;
		$x[0] =~ s/\)$//;
	    }
	    $prob = "\\frac{" . $x[0] . "}{" . $x[1] . "}";
	}
	$prob[$state-1][$prevstate-1] = $prob;
    }
}
close(IN);

open(IN, $ifile2) or die("Cannot read from $ifile2");
$line = <IN>;
while($line = <IN>) {
    @v = split(/\s+/, $line);
    $pattern[$v[0]-1] = $v[1];
}

open(OUT, ">$ofile") or die("Cannot write to $ofile");
print OUT "\\begin{center}\n";
print OUT "\\begin{tabular}{ccc";
foreach $i (1..$maxncol) {
    print OUT "l";
}
print OUT "} \\hline\n";
print OUT "\\multicolumn{2}{c}{State at \$k+1\$} & &\n";
print OUT "\\multicolumn{$maxncol}{c}{State at \$k\$} \\\\\n";
print OUT ("\\cline{1-2} \\cline{4-", $maxncol+3, "}\n");
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
	if($prob[$i][$j] ne "") {
	    print OUT ("& ", $j+1, ": \$", $prob[$i][$j], "\$\n");
	    $nprinted++;
	}
    }
    if($nprinted < $maxncol) {
	foreach $j (1..($maxncol-$nprinted)) {
	    print OUT "& ";
	}
    }
    print OUT "\\\\\n";
}
print OUT "\\hline\n";
print OUT "\\end{tabular}\n";
print OUT "\\end{center}\n";
