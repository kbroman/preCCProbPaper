#!/usr/bin/perl

$n = $ARGV[0];

$n2 = $n;
if($n2 < 10) { $n2 = "0$n2"; }


$ofile = "tmp/xchr$n2.txt";
open(OUT, ">$ofile") or die("Cannot write to $ofile");
print OUT "femCC : 1/(12*r+3) - 1/(3*r+3)*(-1/2)^k + \n";
print OUT "       (9*r^2 +5*r + r*sqrt(r^2-10*r+5))/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*\n";
print OUT "       ((1 - r + sqrt(r^2-10*r+5))/4)^k - \n";
print OUT "       (9*r^2 +5*r - r*sqrt(r^2-10*r+5))/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*\n";
print OUT "       ((1 - r - sqrt(r^2-10*r+5))/4)^k\$\n";
print OUT "femAA : (1/2)*(2/(12*r+3) + 1/(3*r+3)*(-1/2)^k - \n";
print OUT "       (4*r^3 - sqrt(r^2-10*r+5)*(4*r^2+3*r)+3*r^2-5*r)/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*\n";
print OUT "       ((1 - r + sqrt(r^2-10*r+5))/4)^k + \n";
print OUT "       (4*r^3 + sqrt(r^2-10*r+5)*(4*r^2+3*r)+3*r^2-5*r)/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*\n";
print OUT "       ((1 - r - sqrt(r^2-10*r+5))/4)^k)\$\n";
print OUT "malCC : 1/(12*r+3) + 2/(3*r+3)*(-1/2)^k + \n";
print OUT "       (2*r^4 + sqrt(r^2-10*r+5)*(2*r^3-r^2+r)-19*r^3+5*r)/(4*r^4-35*r^3-29*r^2+15*r+5) *\n";
print OUT "       ((1 - r + sqrt(r^2-10*r+5))/4)^k + \n";
print OUT "       (2*r^4 - sqrt(r^2-10*r+5)*(2*r^3-r^2+r)-19*r^3+5*r)/(4*r^4-35*r^3-29*r^2+15*r+5) *\n";
print OUT "       ((1 - r - sqrt(r^2-10*r+5))/4)^k\$\n";
print OUT "malAA : 1/(12*r+3) - 1/(3*r+3)*(-1/2)^k + \n";
print OUT "       (r^3 - sqrt(r^2-10*r+5)*(8*r^3+r^2-3*r)-10*r^2+5*r)/(4*r^4-35*r^3-29*r^2+15*r+5)/2 *\n";
print OUT "       ((1 - r + sqrt(r^2-10*r+5))/4)^k + \n";
print OUT "       +(r^3 + sqrt(r^2-10*r+5)*(8*r^3+r^2-3*r)-10*r^2+5*r)/(4*r^4-35*r^3-29*r^2+15*r+5)/2 *\n";
print OUT "       ((1 - r - sqrt(r^2-10*r+5))/4)^k\$\n";
print OUT "hapAA : radcan((2/3)*femAA + (1/3)*malAA)\$\n";
print OUT "hapCC : radcan((2/3)*femCC + (1/3)*malCC)\$\n";

if($n < 2) { die("Need $n >= 2\n"); }

$a[0][0] = 1;
$a[1][0] = 1;
$a[0][1] = $a[1][1] = 0;
foreach $i (2..($n-1)) {
    foreach $j (0..($n-2)) {
	$a[$i][$j] = $a[$i-1][$j-1] + $a[$i-2][$j-1];
    }
}
@mult1 = @{$a[$n-1]};
@mult2 = @{$a[$n-2]};

print OUT "\n\n";
print OUT "mult1 : ";
foreach $i (0..(@mult1-1)) {
    if($mult1[$i] > 0) {
	print OUT "+ ((1-r)/2)^$i*$mult1[$i] ";
    }
}
print OUT "\$\n";
print OUT "mult2 : ";
foreach $i (0..(@mult2-1)) {
    if($mult2[$i] > 0) {
	print OUT "+ ((1-r)/2)^$i*$mult2[$i] ";
    }
}
print OUT "\$\n\n";
print OUT "R : radcan(1 - ( mult1*hapCC + mult2*hapAA + mult1*hapAA))\$\n";
print OUT "g : radcan(diff(R, r))\$\n";
print OUT "me : radcan(ev(g, r=0))\$\n\n";

print OUT "meauto : n+4 - ((1+sqrt(5))/4)^k * (15 + 7*sqrt(5))/5 - ((1-sqrt(5))/4)^k * (15 - 7*sqrt(5))/5\$\n\n";
print OUT "radcan(me - (2/3)*ev(meauto, n=$n));\n";

close(OUT);

$ofile2 = "tmp/xchr$n2\_out.txt";
system("maxima < $ofile > $ofile2");
