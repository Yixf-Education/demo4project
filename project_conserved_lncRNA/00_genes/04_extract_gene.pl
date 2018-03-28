#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use File::Basename;

my @files = glob "*.fa.gz";

foreach my $fi (@files) {
    my $gb  = $fi =~ /Homo/  ? "hg38" : "rn6";
    my $rna = $fi =~ /ncrna/ ? "NCG"  : "PCG";
    my $fo  = "${gb}_${rna}.txt";
    open my $I, "gunzip -c $fi |"
      or die "$0 : failed to open input file '$fi' : $!\n";
    open my $O, '>', $fo or die "$0 : failed to open output file '$fo' : $!\n";
    select $O;
    print "gene\ttrancript\n";
    while (<$I>) {

        if (/^>/) {
            if (/(ENS(RNO)?G\d+)/) {
                print "$1\t";
            }
            if (/(ENS(RNO)?T\d+)/) {
                print "$1\n";
            }
        }
    }
    close $I or warn "$0 : failed to close input file '$fi' : $!\n";
    close $O or warn "$0 : failed to close output file '$fo' : $!\n";
}

