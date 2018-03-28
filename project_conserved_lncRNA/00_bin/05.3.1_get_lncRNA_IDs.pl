#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my $dio = "05_identification";

my $dim = "04_merged";
my $dip = "$dio/01_CPAT";
my $dic = "$dio/02_compare";
my $dol = "$dio/03_lncRNA";
mkdir $dol unless -d $dol;

my @gbs = ( "HB", "RB" );

foreach my $gb (@gbs) {
    my %lncRNA;
    my $fib = "$dim/$gb" . "_merged.bed";
    open my $IB, '<', $fib
      or die "$0 : failed to open input file '$fib' : $!\n";
    while (<$IB>) {
        chomp;
        my @f   = split /\t/;
        my $len = $f[2] - $f[1];

        # Lenght > 200bp
        if ( $len > 200 ) {
            $lncRNA{ $f[3] } .= "L";
        }
        else {
            $lncRNA{ $f[3] } .= "F";
        }

        # Multi-exonic
        if ( $f[9] > 1 ) {
            $lncRNA{ $f[3] } .= "E";
        }
        else {
            $lncRNA{ $f[3] } .= "F";
        }
    }
    close $IB or warn "$0 : failed to close input file '$fib' : $!\n";

    my $cpco = $gb eq "HB" ? 0.364 : 0.44;
    my $fip = "$dip/$gb" . "_CPAT.txt";
    open my $IP, '<', $fip
      or die "$0 : failed to open input file '$fip' : $!\n";
    while (<$IP>) {
        unless (/^mRNA_size/) {
            chomp;
            my @f = split /\t/;

            # Coding potential < cutoff
            # human: 0.364
            # rat: 0.44
            if ( $f[-1] < $cpco ) {
                $lncRNA{ $f[0] } .= "P";
            }
            else {
                $lncRNA{ $f[0] } .= "F";
            }
        }
    }
    close $IP or warn "$0 : failed to close input file '$fip' : $!\n";

    my $fic = "$dic/$gb" . ".tracking";
    open my $IC, '<', $fic
      or die "$0 : failed to open input file '$fic' : $!\n";
    while (<$IC>) {
        my @f = split /\t/;
        my @t = split /\|/, $f[-1];
        my $g = $t[1];

        # Not overlap with protein-coding genes
        # if ( $f[3] eq "u" ) {
        if ( $f[3] =~ /[iypru]/ ) {
            $lncRNA{$g} .= "C";
        }
        else {
            $lncRNA{$g} .= "F";
        }
    }
    close $IC or warn "$0 : failed to close input file '$fic' : $!\n";

    my $fol = "$dol/$gb" . "_lncRNA.txt";
    open my $OL, '>', $fol
      or die "$0 : failed to open output file '$fol' : $!\n";
    my $fon = "$dol/$gb" . "_non-lncRNA.txt";
    open my $ON, '>', $fon
      or die "$0 : failed to open output file '$fon' : $!\n";
    print $OL "gid\tcode\n";
    print $ON "gid\tcode\n";

    foreach my $g ( sort keys %lncRNA ) {
        if ( $lncRNA{$g} =~ /F/ ) {
            print $ON "$g\t$lncRNA{$g}\n";
        }
        else {
            print $OL "$g\t$lncRNA{$g}\n";
        }
    }
    close $OL or warn "$0 : failed to close output file '$fol' : $!\n";
    close $ON or warn "$0 : failed to close output file '$fon' : $!\n";
}

