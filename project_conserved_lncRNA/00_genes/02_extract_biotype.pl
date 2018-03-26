#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my @files = glob "*.gtf";
my %biotype;

foreach my $fi (@files) {
    open my $I, '<', $fi or die "$0 : failed to open input file '$fi' : $!\n";
    while (<$I>) {
        if (/gene_biotype\s+"(.+?)";.+?transcript_biotype\s+"(.+?)";/) {
            $biotype{$1} = "gene";
            $biotype{$2} = "transcript";
        }
    }
    close $I or warn "$0 : failed to close input file '$fi' : $!\n";
}

my $fo = "Ensembl_biotype.txt";
open my $O, '>', $fo or die "$0 : failed to open output file '$fo' : $!\n";
select $O;
foreach my $bt ( sort { $biotype{$a} cmp $biotype{$b} } keys %biotype ) {
    print "$bt\t$biotype{$bt}\n";
}
close $O or warn "$0 : failed to close output file '$fo' : $!\n";

