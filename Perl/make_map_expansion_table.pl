#!/usr/bin/perl

$ofile1 = "Tables/map_expansion_table.tex";
$ofile2 = "R/map_expansion_func.R";
open(OUT1, ">$ofile1") or die("Cannot write to $ofile1");
open(OUT2, ">$ofile2") or die("Cannot write to $ofile2");

$fromsub[0] = "left\\(";   $tosub[0] = "\\left(";   $tosubB[0] = "(";
$fromsub[1] = "right\\)";  $tosub[1] = "\\right)";  $tosubB[1] = ")";
$fromsub[2] = "left\\[";   $tosub[2] = "\\left[";   $tosubB[2] = "(";
$fromsub[3] = "right\\]";  $tosub[3] = "\\right]";  $tosubB[3] = ")";
$fromsub[4] = "\\*";       $tosub[4] = "";	    $tosubB[4] = "*";	   
$fromsub[5] = "sqrt";      $tosub[5] = "\\sqrt";    $tosubB[5] = "sqrt";   
$fromsub[6] = "\\{";       $tosub[6] = "{";         $tosubB[6] = "(";   
$fromsub[7] = "\\}";       $tosub[7] = "}";         $tosubB[7] = ")";   
$fracsub = "frac\\[([^\]]+),([^\]]+)\\]";

print " -autosome, sib-mating\n";
$ifile = "Calculations/TwolociA4/map_expansion.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $cross = $v[0];
    $prob = join(" ", @v[1..(@v-1)]);
    $problatex = $probR = $prob;
    foreach $i (0..(@fromsub-1)) {
	$problatex =~ s/$fromsub[$i]/$tosub[$i]/g;
	$probR =~ s/$fromsub[$i]/$tosubB[$i]/g;
    }
    while($problatex =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$problatex =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
	$probR =~ s/$fracsub/(($1)\/($2))/;
    }

    if($cross eq "") { next; }
    $problatex{$cross}{"sibA"} = $problatex;
    $probR{$cross}{"sibA"} = $probR;
}
close(IN);
    
    
print " -X chr, sib-mating\n";
$ifile = "Calculations/TwolociX4/map_expansion.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $cross = $v[0];
    $prob = join(" ", @v[1..(@v-1)]);
    $problatex = $probR = $prob;
    foreach $i (0..(@fromsub-1)) {
	$problatex =~ s/$fromsub[$i]/$tosub[$i]/g;
	$probR =~ s/$fromsub[$i]/$tosubB[$i]/g;
    }
    while($problatex =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$problatex =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
	$probR =~ s/$fracsub/(($1)\/($2))/;
    }

    if($cross eq "") { next; }
    $problatex{$cross}{"sibX"} = $problatex;
    $probR{$cross}{"sibX"} = $probR;
}
close(IN);
    
    
print " -selfing\n";
$ifile = "Calculations/Selfing/map_expansion.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $cross = $v[0];
    $prob = join(" ", @v[1..(@v-1)]);
    $problatex = $probR = $prob;
    foreach $i (0..(@fromsub-1)) {
	$problatex =~ s/$fromsub[$i]/$tosub[$i]/g;
	$probR =~ s/$fromsub[$i]/$tosubB[$i]/g;
    }
    while($problatex =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$problatex =~ s/$fracsub/\\frac\{$1\}\{$2\}/;
	$probR =~ s/$fracsub/(($1)\/($2))/;
    }

    if($cross eq "") { next; }
    $problatex{$cross}{"self"} = $problatex;
    $probR{$cross}{"self"} = $probR;
}
close(IN);
    
    
@nstr = ("Two-way", "Four-way", "Eight-way", "2^n-way");

print OUT1 "{\\small \\begin{center}\n";
print OUT1 "\\renewcommand{\\arraystretch}{1.5}\\begin{tabular}{c\@{\\hspace{1cm}}c\@{\\hspace{1cm}}c}";
print OUT1 "\\hline\n";
print OUT1 " & Selfing & Sibling mating (autosome) \\\\ \\hline \n";
foreach $nstr (@nstr) {
    if($nstr =~ /\^/) {
	print OUT1 "\$2^n\$-way ";
    }
    else {
	print OUT1 "$nstr ";
    }
    foreach $cross ("self", "sibA") {
	print OUT1 "& \$$problatex{$nstr}{$cross}\$ ";
    }
    print OUT1 "\\\\ \n";
}
print OUT1 "\\hline\n";
print OUT1 "\\end{tabular}\n";
print OUT1 "\\end{center} }\n\n";
print OUT1 "\\noindent Notes: For selfing, \$k \\ge 1\$ and \$n \\ge 1\$.\n";
print OUT1 "For sibling mating, \$k \\ge 0\$ and \$n \\ge 2\$.\n";
print OUT1 "The map expansion for the X chromosome with sibling mating is 2/3 that of the autosome.\n";


@altnstr = (2,4,8);
foreach $i (0..(@altnstr-1)) {
    print OUT2 "###############\n";
    print OUT2 "# $nstr[$i]\n";
    print OUT2 "###############\n";
    foreach $cross ("self", "sibX", "sibA") {
	print OUT2 "me$cross$altnstr[$i] <- function(k)\n";
	print OUT2 "    $probR{$nstr[$i]}{$cross}\n\n";
    }
}


