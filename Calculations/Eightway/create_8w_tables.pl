#!/usr/bin/perl

print " -Autosome\n";
$file = "statesA8.txt";
unless(-e $file) {
    system("../CalcTM/countIndStates 8 X 1 > $file");
}

$total = 0; %count = ();
open(IN, $file) or die("Cannot read from $file");
foreach $i (1..6) { $line = <IN>; }
while($line = <IN>) {
    if($line =~ /Total/) { next; }
    ($state, $count) = split(/\s+/, $line);
    if($state eq "") { next; }
    ($hapa, $hapb) = split(/\|/, $state);
    if($hapa ne $hapb) { $count /= 2; }
    $total += $count;
    $count{$state} = $count;
}
print " No. individuals = $total\n";

$ofile = "statesA8_rev.txt";
open(OUT, ">$ofile") or die("Cannot write to $ofile");
%state4w = ();
foreach $state (keys %count) {
    $state4w = $state;
    $state4w =~ s/A|B/A/g;
    $state4w =~ s/C|D/B/g;
    $state4w =~ s/E|F/C/g;
    $state4w =~ s/G|H/D/g;
    $state4w{$state} = $state4w;
}
foreach $state (sort by4w (keys %count)) {
    $statelc = $state; #    $statelc = lc $state;

    printf OUT ("%5s   %3d   %5s   ", $statelc, $count{$state}, $state4w{$state});

    @v = split(/\|*/, $state);
    @vn = (0, 0, 0, 0);
    foreach $i (0..(@v-1)) {
	if($v[$i] eq "A") { $vn[$i] = 1; }
	elsif($v[$i] eq "B") { $vn[$i] = 2; }
	elsif($v[$i] eq "C") { $vn[$i] = 11; }
	elsif($v[$i] eq "D") { $vn[$i] = 12; }
	elsif($v[$i] eq "E") { $vn[$i] = 21; }
	elsif($v[$i] eq "F") { $vn[$i] = 22; }
	elsif($v[$i] eq "G") { $vn[$i] = 31; }
	elsif($v[$i] eq "H") { $vn[$i] = 32; }
    }

    $loc1 = $v[0] . $v[2];
    $loc2 = $v[1] . $v[3];

    $prob = "";
    if($vn[0] - $vn[2] == 1 or $vn[2] - $vn[0] == 1 or
       $vn[1] - $vn[3] == 1 or $vn[3] - $vn[1] == 1) {  # not allowed
    	$prob = 0;
    }
    else { 
	if($state =~ /A/ and $state =~ /B/) {
	    if($prob eq "") { $prob = "r/2"; }
	    else { $prob .= "*r/2"; }
	}
	elsif($loc1 =~ /A|B/ and $loc2 =~ /A|B/) {
	    if($prob eq "") { $prob = "(1-r)/2"; }
	    else { $prob .= "*(1-r)/2"; }
	}
	elsif($state =~ /A|B/) {
	    if($prob eq "") { $prob = "1/2"; }
	    else { $prob .= "/2"; }
	}

	if($state =~ /C/ and $state =~ /D/) {
	    if($prob eq "") { $prob = "r/2"; }
	    else { $prob .= "*r/2"; }
	}
	elsif($loc1 =~ /C|D/ and $loc2 =~ /C|D/) {
	    if($prob eq "") { $prob = "(1-r)/2"; }
	    else { $prob .= "*(1-r)/2"; }
	}
	elsif($state =~ /C|D/) {
	    if($prob eq "") { $prob = "1/2"; }
	    else { $prob .= "/2"; }
	}

	if($state =~ /E/ and $state =~ /F/) {
	    if($prob eq "") { $prob = "r/2"; }
	    else { $prob .= "*r/2"; }
	}
	elsif($loc1 =~ /E|F/ and $loc2 =~ /E|F/) {
	    if($prob eq "") { $prob = "(1-r)/2"; }
	    else { $prob .= "*(1-r)/2"; }
	}
	elsif($state =~ /E|F/) {
	    if($prob eq "") { $prob = "1/2"; }
	    else { $prob .= "/2"; }
	}

	if($state =~ /G/ and $state =~ /H/) {
	    if($prob eq "") { $prob = "r/2"; }
	    else { $prob .= "*r/2"; }
	}
	elsif($loc1 =~ /G|H/ and $loc2 =~ /G|H/) {
	    if($prob eq "") { $prob = "(1-r)/2"; }
	    else { $prob .= "*(1-r)/2"; }
	}
	elsif($state =~ /G|H/) {
	    if($prob eq "") { $prob = "1/2"; }
	    else { $prob .= "/2"; }
	}
    }

    if($prob eq "(1-r)/2") { $prob = "frac[1-r,2]"; }
    elsif($prob eq "(1-r)/2/2") { $prob = "frac[1-r,4]"; }
    elsif($prob eq "(1-r)/2/2/2") { $prob = "frac[1-r,8]"; }
    elsif($prob eq "(1-r)/2*(1-r)/2") { $prob = "frac[(1-r)^2,4]"; }
    elsif($prob eq "(1-r)/2*r/2") { $prob = "frac[r*(1-r),4]"; }    
    elsif($prob eq "1/2*(1-r)/2/2") { $prob = "frac[1-r,8]"; }      
    elsif($prob eq "1/2*r/2/2") { $prob = "frac[r,8]"; }          
    elsif($prob eq "1/2/2") { $prob = "frac[1,4]"; }              
    elsif($prob eq "1/2/2*(1-r)/2") { $prob = "frac[1-r,8]"; }      
    elsif($prob eq "1/2/2*r/2") { $prob = "frac[r,8]"; }          
    elsif($prob eq "1/2/2/2") { $prob = "frac[1,8]"; }            
    elsif($prob eq "1/2/2/2/2") { $prob = "frac[1,16]"; }          
    elsif($prob eq "r/2") { $prob = "frac[r,2]"; }                
    elsif($prob eq "r/2*(1-r)/2") { $prob = "frac[r*(1-r),4]"; }        
    elsif($prob eq "r/2*r/2") { $prob = "frac[r^2,4]"; }            
    elsif($prob eq "r/2/2") { $prob = "frac[r,4]"; }              
    elsif($prob eq "r/2/2/2") { $prob = "frac[r,8]"; }            

    print OUT "$prob\n";
} 


######################################################################

print " -X chr\n";
$file = "statesX8.txt";
unless(-e $file) {
    system("../CalcTM/countIndStates 8 X 1 > $file");
}

$total = 0; %count = ();
open(IN, $file) or die("Cannot read from $file");
foreach $i (1..6) { $line = <IN>; }
while($line = <IN>) {
    if($line =~ /Total/) { next; }
    ($state, $count) = split(/\s+/, $line);
    if($state eq "") { next; }
    ($hapa, $hapb) = split(/\|/, $state);
    if($hapa ne $hapb) { $count /= 2; }
    $total += $count;
    $count{$state} = $count;
}
print " No. individuals = $total\n";

# need to change the 4-way 'prototypes'
$tochange{"AB|BB"} = "AA|AB";
$tochange{"AB|CA"} = "AB|BC";	
$tochange{"AB|CB"} = "AB|AC";	
$tochange{"AC|BB"} = "AA|BC";	
$tochange{"BB|BB"} = "AA|AA";	
$tochange{"BB|BC"} = "AA|AC";	
$tochange{"BB|CC"} = "AA|CC";	
$tochange{"BC|BC"} = "AC|AC";	
$tochange{"BC|CB"} = "AC|CA";	
$tochange{"BC|CC"} = "AC|CC";


$ofile = "statesX8_rev.txt";
open(OUT, ">$ofile") or die("Cannot write to $ofile");
$ofile = "statesX8_rev_alt.txt";
open(OUT2, ">$ofile") or die("Cannot write to $ofile");
%state4w = ();
foreach $state (keys %count) {
    $state4w = $state;
    $state4w =~ s/A|B/A/g;
    $state4w =~ s/C/B/g;
    $state4w =~ s/E|F/C/g;

    $state4w{$state} = $state4w;

    $state4walt = $state4w;
    if($tochange{$state4walt} ne "") {
	$state4walt = $tochange{$state4walt};
    }
				 
    $state4walt{$state} = $state4walt;
}
foreach $state (sort by4w (keys %count)) {
    $statelc = $state; #    $statelc = lc $state;

    printf OUT ("%5s   %3d   %5s   ", $statelc, $count{$state}, $state4w{$state});
    printf OUT2 ("%5s   %3d   %5s   ", $statelc, $count{$state}, $state4walt{$state});

    @v = split(/\|*/, $state);
    @vn = (0, 0, 0, 0);
    foreach $i (0..(@v-1)) {
	if($v[$i] eq "A") { $vn[$i] = 1; }
	elsif($v[$i] eq "B") { $vn[$i] = 2; }
	elsif($v[$i] eq "C") { $vn[$i] = 11; }
	elsif($v[$i] eq "E") { $vn[$i] = 21; }
	elsif($v[$i] eq "F") { $vn[$i] = 22; }
    }

    $loc1 = $v[0] . $v[2];
    $loc2 = $v[1] . $v[3];

    $prob = "";
    if($vn[0] - $vn[2] == 1 or $vn[2] - $vn[0] == 1 or
       $vn[1] - $vn[3] == 1 or $vn[3] - $vn[1] == 1) {  # not allowed
    	$prob = 0;
    }
    else { 
	if($state =~ /A/ and $state =~ /B/) {
	    if($prob eq "") { $prob = "r/2"; }
	    else { $prob .= "*r/2"; }
	}
	elsif($loc1 =~ /A|B/ and $loc2 =~ /A|B/) {
	    if($prob eq "") { $prob = "(1-r)/2"; }
	    else { $prob .= "*(1-r)/2"; }
	}
	elsif($state =~ /A|B/) {
	    if($prob eq "") { $prob = "1/2"; }
	    else { $prob .= "/2"; }
	}


	if($state =~ /E/ and $state =~ /F/) {
	    if($prob eq "") { $prob = "r/2"; }
	    else { $prob .= "*r/2"; }
	}
	elsif($loc1 =~ /E|F/ and $loc2 =~ /E|F/) {
	    if($prob eq "") { $prob = "(1-r)/2"; }
	    else { $prob .= "*(1-r)/2"; }
	}
	elsif($state =~ /E|F/) {
	    if($prob eq "") { $prob = "1/2"; }
	    else { $prob .= "/2"; }
	}

	if($prob eq "") { $prob = "1"; }
    }

    if($prob    eq "(1-r)/2") { $prob = "frac[1-r,2]"; }        
    elsif($prob eq "(1-r)/2*(1-r)/2") { $prob = "frac[(1-r)^2,4]"; }        
    elsif($prob eq "(1-r)/2*r/2") { $prob = "frac[r*(1-r),4]"; }            
    elsif($prob eq "(1-r)/2/2") { $prob = "frac[1-r,4]"; }              
    elsif($prob eq "1/2") { $prob = "frac[1,2]"; }                    
    elsif($prob eq "1/2*(1-r)/2") { $prob = "frac[1-r,4]"; }            
    elsif($prob eq "1/2*r/2") { $prob = "frac[r,4]"; }                
    elsif($prob eq "1/2/2") { $prob = "frac[1,4]"; }                  
    elsif($prob eq "r/2") { $prob = "frac[r,2]"; }                    
    elsif($prob eq "r/2*(1-r)/2") { $prob = "frac[r*(1-r),4]"; }            
    elsif($prob eq "r/2*r/2") { $prob = "frac[r^2,4]"; }                
    elsif($prob eq "r/2/2") { $prob = "frac[r,4]"; }        

    print OUT "$prob\n";
    print OUT2 "$prob\n";
} 


######################################################################

sub by4w {
    if($state4w{$a} eq $state4w{$b}) {
	return($a cmp $b);
    }
    $state4w{$a} cmp $state4w{$b};
}
