#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my $dio = "05_identification/03_lncRNA";
my $dim = "04_merged";
my $dit = "00_tools/ea-utils-1.04.807/clipper/";

my @gbs = ( "HB", "RB" );
foreach my $gb (@gbs) {
    my %lncRNA;
    my $fi = "$dio/$gb" . "_lncRNA.txt";
    open my $I, '<', $fi or die "$0 : failed to open input file '$fi' : $!\n";
    while (<$I>) {
        unless (/^gid/) {
            my @f = split /\t/;
            $lncRNA{ $f[0] } = 1;
        }
    }
    close $I or warn "$0 : failed to close input file '$fi' : $!\n";

    my $fog = "$dio/$gb" . "_lncRNA.gtf";
    open my $OG, '>', $fog
      or die "$0 : failed to open output file '$fog' : $!\n";
    select $OG;
    my $fig = "$dim/$gb" . "_merged.gtf";
    open my $IG, '<', $fig
      or die "$0 : failed to open input file '$fig' : $!\n";
    while (<$IG>) {

        if (/^#/) {
            print;
        }
        else {
            if (/transcript_id "(.+?)"/) {
                if ( exists $lncRNA{$1} ) {
                    print;
                }
            }
        }
    }
    close $IG or warn "$0 : failed to close input file '$fig' : $!\n";
    close $OG or warn "$0 : failed to close output file '$fog' : $!\n";

    my $fob = "$dio/$gb" . "_lncRNA.bed";
    system "$dit/gtf2bed $fog > $fob";
}
