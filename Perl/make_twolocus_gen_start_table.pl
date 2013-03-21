#!/usr/bin/perl

$ifile1 = $ARGV[0]; # start probabilities
$ifile2 = $ARGV[1]; # states (to become pictograms)
$ofile =  $ARGV[2];
open(IN, $ifile1) or die("Cannot read from $ifile1");
$line = <IN>;
while($line = <IN>) {
    @v = split(/\s+/, $line);
    $prototype = $v[0];
    if($prototype eq "") { next; }
    $nstates = $v[1];
    $nstates =~ s/\(|\)//g;
    shift @v;
    foreach $i (1..(@v-1)) {
	if($v[$i] != 0) {
	    $start = $i;
	    $prob = $v[$i];
	    last;
	}
    }
    push(@prototypes, $prototype);
    push(@nstates, $nstates);
    push(@starts, $start);
    push(@prob, $prob);
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
print OUT "\\begin{tabular}{ccrlc} \\hline\n";
print OUT "Prototype & No. states & \\multicolumn{2}{c}{Initial pattern} & Initial probability \\\\ \\hline\n";
foreach $i (0..(@nstates-1)) {
    print OUT "\$$prototypes[$i]\$ & $nstates[$i] & \n";
    @pat = split(/\||x|/, $pattern[$starts[$i]-1]);
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

    print OUT "& ($starts[$i]) & \$$prob[$i]\$ \\\\\n";
}
print OUT "\\hline\n";
print OUT "\\end{tabular}\n";
print OUT "\\end{center}\n";
