#!/usr/bin/perl

use warnings;
use strict;
use utf8;

# https://asia.ensembl.org/Help/Faq?id=468
# Long noncoding: 3prime overlapping ncrna, ambiguous orf, antisense, antisense RNA, lincRNA, ncrna host, processed transcript, sense intronic, sense overlapping

my %lncRNA = (
    "3prime_overlapping_ncRNA" => 1,
    "antisense_RNA"            => 1,
    "lincRNA"                  => 1,
    "processed_transcript"     => 1,
    "sense_intronic"           => 1,
    "sense_overlapping"        => 1,
);

my @gbs = ( "hg38", "rn6" );
foreach my $gb (@gbs) {
    my $fi = "$gb" . "_NCG.gtf";
    open my $I, '<', $fi or die "$0 : failed to open input file '$fi' : $!\n";
    my $fo = "$gb" . "_lncRNA.gtf";
    open my $O, '>', $fo or die "$0 : failed to open output file '$fo' : $!\n";
    select $O;
    while (<$I>) {
        if (/^#/) {
            print;
        }
        else {
            my @f = split /\t/;
            unless ( $f[2] eq "gene" ) {
                if (/gene_biotype "(.+?)"/) {
                    if ( exists $lncRNA{$1} ) {
                        print;
                    }
                }
            }
        }
    }
    close $I or warn "$0 : failed to close input file '$fi' : $!\n";
    close $O or warn "$0 : failed to close output file '$fo' : $!\n";
}
