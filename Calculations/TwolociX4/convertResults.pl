#!/usr/bin/perl

$ifile = "male_hap.txt";
$ofile = "R/male_hap.R";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile"); 
$line = <IN>;
print OUT $line;
print OUT "malehaporig <- function(r,k) c(\n";
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

$ifile = "male_hap_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "malehap <- function(r,k) c(\n";
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
$ifile = "male_hap_matrix.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "malehaptm <- function(r) rbind(\n";
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
$ifile = "male_hap_start.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "malehapstart <- rbind(\n";
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
    
print OUT "\n\nb <- rbind(1, 0, 0, 0)\n";



$ifile = "female_AA_AA_matrix_alt.txt";
$ofile = "R/femaleAAAA.R";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile");

$line = <IN>;
print OUT $line;
print OUT "femaleAAAAtm <- function(r) cbind(\n";
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

print OUT "femaleAAAAstart <- matrix(0, nrow=4, ncol=13)\n";
print OUT "femaleAAAAstart[1,4] <- 1/2\n";
print OUT "femaleAAAAstart[2,9] <- 1/2\n";
print OUT "femaleAAAAstart[3,8] <- 1/4\n";
print OUT "femaleAAAAstart[4,10] <- 1\n";
print OUT "b <- as.matrix(c(1, rep(0,12)))\n";


$ifile = "female_hap.txt";
$ofile = "R/female_hap.R";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile"); 
print OUT "\n\nb <- rbind(1, 0, 0, 0)\n\n";

$line = <IN>;
print OUT $line;
print OUT "femalehaporig <- function(r,k) c(\n";
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

$ifile = "female_hap_rev.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "femalehap <- function(r,k) c(\n";
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
$ifile = "female_hap_matrix.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "femalehaptm <- function(r) rbind(\n";
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
$ifile = "female_hap_start.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "femalehapstart <- rbind(\n";
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
    
print OUT "\n\nbhap <- rbind(1, 0, 0, 0)\n";


$ofile = "R/femaleAABB.R";
$ifile = "female_AA_BB_matrix_alt.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile");
$line = <IN>;
print OUT $line;
print OUT "femaleAABBtm <- function(r) cbind(\n";
$flag = 0;
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    $line =~ s/\[/(/g;
    $line =~ s/\]/)/g;
    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    if($v[0] eq "") { next; }
    $row = substr($v[0], 0, length($v[0])-1);
    shift @v;
    @x = ();
    foreach $i (0..11) { $x[$i] = "0"; }
    foreach $i (0..(@v/2-1)) {
	$x[substr($v[2*$i], 0, length($v[2*$i])-1)-1] = $v[2*$i+1];
    }
    print OUT ("c(", join(",", @x), ")");
}
print OUT "\n)\n\n";

$ifile = "female_AA_BB_start.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "femaleAABBstart <- rbind(\n";
$flag = 0;
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    $line =~ s/\[/(/g;
    $line =~ s/\]/)/g;
    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    print OUT ("\"$v[0]\"=c(", join(",", @v[2..(@v-1)]), ")");
}
print OUT "\n)\n\n";


print OUT "b <- as.matrix(c(1, rep(0,11)))\n";

######################################################################

$ofile = "Maxima/femaleAABBtm.txt";
$ifile = "female_AA_BB_matrix_alt.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile");
$line = <IN>; chomp($line);
print OUT "/* $line */\n";
print OUT "tm : matrix(\n";
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
    foreach $i (0..11) { $x[$i] = "0"; }
    foreach $i (0..(@v/2-1)) {
	$x[substr($v[2*$i], 0, length($v[2*$i])-1)-1] = $v[2*$i+1];
    }
    print OUT ("[", join(",", @x), "]");
}
print OUT "\n)\$\n\n";

######################################################################

$ofile = "R/femaleAAAB.R";
$ifile = "female_AA_AB_matrix_rev2.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
open(OUT, ">$ofile") or die("Cannot write to $ofile");
$line = <IN>;
print OUT $line;
print OUT "femaleAAABtm <- function(r) cbind(\n";
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
    foreach $i (0..17) { $x[$i] = "0"; }
    foreach $i (0..(@v/2-1)) {
	$x[substr($v[2*$i], 0, length($v[2*$i])-1)-1] = $v[2*$i+1];
    }
    print OUT ("c(", join(",", @x), ")");
}
print OUT "\n)\n\n";

$ifile = "female_AA_AB_start_rev2.txt";
open(IN, $ifile) or die("Cannot read from $ifile");
$line = <IN>;
print OUT $line;
print OUT "femaleAAABstart <- rbind(\n";
$flag = 0;
while($line = <IN>) {
    if(!$flag) { $flag = 1; }
    else { print OUT ",\n"; }
    chomp($line);
    $line =~ s/\[/(/g;
    $line =~ s/\]/)/g;
    @v = split(/\s+/, $line);
    if($v[0] eq "") { shift @v; }
    print OUT ("\"$v[0]\"=c(", join(",", @v[2..(@v-1)]), ")");
}
print OUT "\n)\n\n";


print OUT "b <- as.matrix(c(1, rep(0,17)))\n";

