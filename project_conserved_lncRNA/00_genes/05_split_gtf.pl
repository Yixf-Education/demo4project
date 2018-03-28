#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my @gbs = ( "hg38", "rn6" );

foreach my $gb (@gbs) {
    my %gene;
    my $fip = "$gb" . "_PCG.txt";
    open my $IP, '<', $fip
      or die "$0 : failed to open input file '$fip' : $!\n";
    while (<$IP>) {
        if (/^ENS/) {
            chomp;
            my @f = split /\t/;
            $gene{ $f[0] } = "PCG";
        }
    }
    close $IP or warn "$0 : failed to close input file '$fip' : $!\n";

    my $fin = "$gb" . "_NCG.txt";
    open my $IN, '<', $fin
      or die "$0 : failed to open input file '$fin' : $!\n";
    while (<$IN>) {
        if (/^ENS/) {
            chomp;
            my @f = split /\t/;
            $gene{ $f[0] } = "NCG";
        }
    }
    close $IN or warn "$0 : failed to close input file '$fin' : $!\n";

    #my @files = ( "$gb" . ".gtf", "$gb" . ".gff3" );
    my @files = ( "$gb" . ".gtf" );
    foreach my $fi (@files) {
        my $fmt = $fi =~ /gff3/ ? "gff3" : "gtf";
        my $fop = "$gb" . "_PCG.$fmt";
        open my $OP, '>', $fop
          or die "$0 : failed to open output file '$fop' : $!\n";
        my $fon = "$gb" . "_NCG.$fmt";
        open my $ON, '>', $fon
          or die "$0 : failed to open output file '$fon' : $!\n";
        my $foe = "$gb" . "_ERR.$fmt";
        open my $OE, '>', $foe
          or die "$0 : failed to open output file '$foe' : $!\n";
        open my $I, '<', $fi
          or die "$0 : failed to open input file '$fi' : $!\n";

        while (<$I>) {
            if (/^#/) {
                print $OP $_;
                print $ON $_;
            }
            else {
                if (/(ENS(RNO)?G\d+)/) {
                    if ( exists $gene{$1} && $gene{$1} eq "PCG" ) {
                        print $OP $_;
                    }
                    elsif ( exists $gene{$1} && $gene{$1} eq "NCG" ) {
                        print $ON $_;
                    }
                    else {
                        print $OE $_;
                    }
                }
                else {
                    print $OE $_;
                }
            }
        }
        close $I  or warn "$0 : failed to close input file '$fi' : $!\n";
        close $OP or warn "$0 : failed to close output file '$fop' : $!\n";
        close $ON or warn "$0 : failed to close output file '$fon' : $!\n";
        close $OE or warn "$0 : failed to close output file '$foe' : $!\n";

    }
}
