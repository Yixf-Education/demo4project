#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use File::Basename;

my @files = glob "*.gz";

foreach my $fi (@files) {
    my $gb  = $fi =~ /Homo/ ? "hg38" : "rn6";
    my $fmt = $fi =~ /gff3/ ? "gff3" : "gtf";
    my $fo  = "${gb}.${fmt}";
    open my $I, "gunzip -c $fi |"
      or die "$0 : failed to open input file '$fi' : $!\n";
    open my $O, '>', $fo or die "$0 : failed to open output file '$fo' : $!\n";
    select $O;
    while (<$I>) {
        s/sequence-region(\s+)(MT)(\s+)/sequence-region$1M$3/;
        s/sequence-region(\s+)(.+?)(\s+)/sequence-region$1chr$2$3/;
        unless (/^#/) {
            s/^MT/M/;
            s/^/chr/;
        }
        print;
    }
    close $I or warn "$0 : failed to close input file '$fi' : $!\n";
    close $O or warn "$0 : failed to close output file '$fo' : $!\n";
}

