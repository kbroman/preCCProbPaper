#!/usr/bin/perl

$ifile = "AA_AA_matrix_alt.txt";
$ofile = "R/AA_AA.R";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile"); 
$line = <IN>;
print OUT $line;
print OUT "indAAAAtm <- function(r) cbind(\n";
$flag = 0;
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    $line =~ s/\[/(/g;
    $line =~ s/\]/)/g;

    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    $row = substr($v[0], 0, length($v[0])-1);
    shift @v;
    foreach $i (0..12) { $x[$i] = "0"; }
    foreach $i (0..(@v/2-1)) {
	$x[substr($v[2*$i], 0, length($v[2*$i])-1)-1] = $v[2*$i+1];
    }
    print OUT ("c(", join(",", @x), ")");
}
print OUT "\n)\n\n";

print OUT "startAA.AA <- c(rep(0, 4), 1/4, rep(0, 13-5))\n";
print OUT "startAB.AB <- c(rep(0, 5), 1/4, rep(0, 13-6))\n";
print OUT "startAC.AC <- c(rep(0, 10), 1/8, rep(0, 13-11))\n\n";
print OUT "b <- c(1, rep(0,12))\n";

######################################################################

$ifile = "hap.txt";
$ofile = "R/hap.R";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile"); 
$line = <IN>;
print OUT $line;
print OUT "haporig <- function(r,k) c(\n";
%prob = ();
while($line = <IN>) {
    chomp($line);
    if($line =~ /^# (\w+)/) {
	foreach $i (1..5) {
	    $prob{$1} .= <IN>;
	}
    }
    else { last; }
}

$flag = 0;
foreach $key (sort keys %prob) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    print OUT "\"$key\"= $prob{$key}"
}
print OUT ")";


$fromsub[0] = "left\\(";   $tosub[0] = "(";
$fromsub[1] = "right\\)";   $tosub[1] = ")";
$fromsub[2] = "left\\[";   $tosub[2] = "(";
$fromsub[3] = "right\\]";   $tosub[3] = ")";
$fromsub[4] = "\\}";   $tosub[4] = ")";
$fromsub[5] = "\\{";   $tosub[5] = "(";
$fromsub[6] = "\}";   $tosub[6] = ")";
$fromsub[7] = "\{";   $tosub[7] = "(";
$fracsub = "frac\\[([^\]]+),([^\]]+)\\]";

$ifile = "hap_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "hap <- function(r,k) c(\n";
%prob = ();
while($line = <IN>) {
    chomp($line);
    @v = split(/\s+/, $line);
    $state = $v[0];
    if($state eq "") { next; }
    $prob = join(" ", @v[2..(@v-1)]);


    foreach $i (0..(@fromsub-1)) {
	$prob =~ s/$fromsub[$i]/$tosub[$i]/g;
    }
    while($prob =~ /$fracsub/) {
	$sub1 = $1;
	$sub2 = $2;
	$prob =~ s/$fracsub/(($1)\/($2))/;
    }

    $prob{$state} = $prob;
}

$flag = 0;
foreach $key (sort keys %prob) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    print OUT "\"$key\"= $prob{$key}"
}
print OUT ")";




print OUT "\n\n";
$ifile = "hap_matrix.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "haptm <- function(r) rbind(\n";
$line = <IN>; chomp($line);
@head = split(/\s+/, $line);
if($head[0] eq "") { shift @head; }
$flag = 0;
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    if($line =~ /^\s*$/) { next; }
    @v = split(/\s+/, $line);
    print OUT "\"$v[0]\" = ";
    print OUT "c(";
    foreach $i (0..(@head-1)) {
	if($i > 0) { print OUT ", "; }
	print OUT "\"$head[$i]\" = $v[$i+1]", 
    }
    print OUT ")\n";
}
print OUT ")\n";
    
print OUT "\n\n";
$ifile = "hap_start.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "hapstart <- rbind(\n";
$line = <IN>; chomp($line);
@head = split(/\s+/, $line);
if($head[0] eq "") { shift @head; }
$flag = 0;
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    if($line =~ /^\s*$/) { next; }
    @v = split(/\s+/, $line);
    print OUT "\"$v[0]\" = ";
    print OUT "c(";
    foreach $i (0..(@head-1)) {
	if($i > 0) { print OUT ", "; }
	print OUT "\"$head[$i]\" = $v[$i+1]", 
    }
    print OUT ")\n";
}
print OUT ")\n";
    
print OUT "\n\nb <- rbind(1, 0, 0)\n";

######################################################################

$ofile = "R/AA_BB.R";
$ifile = "AA_BB_matrix.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile");
$line = <IN>;
print OUT $line;
print OUT "indAABBtm <- function(r) cbind(\n";
$flag = 0;
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    $line =~ s/\[/(/g;
    $line =~ s/\]/)/g;
    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    $row = substr($v[0], 0, length($v[0])-1);
    shift @v;
    foreach $i (0..13) { $x[$i] = "0"; }
    foreach $i (0..(@v/2-1)) {
	$x[substr($v[2*$i], 0, length($v[2*$i])-1)-1] = $v[2*$i+1];
    }
    print OUT ("c(", join(",", @x), ")");
}
print OUT "\n)\n\n";

$ifile = "AA_BB_start.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "indAABBstart <- rbind(\n";
$flag = 0;
@mult = ();
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    $line =~ s/\[/(/g;
    $line =~ s/\]/)/g;
    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    print OUT ("\"$v[0]\"=c(", join(",", @v[2..(@v-1)]), ")");
    $v[1] =~ s/\(//g;
    $v[1] =~ s/\)//g;
    push(@mult, $v[1]);
}
print OUT "\n)\n\n";

print OUT ("mult <- c(", join(",", @mult), ")\n\n");
print OUT ("pi0 <- indAABBstart * mult\n");

print OUT "b <- as.matrix(c(1, rep(0,13)))\n";

######################################################################

$ofile = "R/AA_AB.R";
$ifile = "AA_AB_matrix_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile");
$line = <IN>;
print OUT $line;
print OUT "indAAABtm <- function(r) cbind(\n";
$flag = 0;
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    $line =~ s/\[/(/g;
    $line =~ s/\]/)/g;
    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    $row = substr($v[0], 0, length($v[0])-1);
    shift @v;
    foreach $i (0..16) { $x[$i] = "0"; }
    foreach $i (0..(@v/2-1)) {
	$x[substr($v[2*$i], 0, length($v[2*$i])-1)-1] = $v[2*$i+1];
    }
    print OUT ("c(", join(",", @x), ")");
}
print OUT "\n)\n\n";

$ifile = "AA_AB_start_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "indAAABstart <- rbind(\n";
$flag = 0;
@mult = ();
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    $line =~ s/\[/(/g;
    $line =~ s/\]/)/g;
    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    print OUT ("\"$v[0]\"=c(", join(",", @v[2..(@v-1)]), ")");
    $v[1] =~ s/\(//g;
    $v[1] =~ s/\)//g;
    push(@mult, $v[1]);
}
print OUT "\n)\n\n";

print OUT ("mult <- c(", join(",", @mult), ")\n\n");
print OUT ("pi0 <- indAAABstart * mult\n");

print OUT "b <- as.matrix(c(1, rep(0,16)))\n";

