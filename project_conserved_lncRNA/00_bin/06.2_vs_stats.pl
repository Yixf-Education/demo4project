#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use File::Basename;

my $dib = "05_identification/03_lncRNA";
my $fia = "$dib/HB_lncRNA.bed";

my $total = `cat $fia | wc -l`;
chomp($total);

my $dio   = "06_vs_database";
my @files = glob "$dio/*.bed";
my $fo    = "$dio/vs_stats.txt";
open my $O, '>', $fo or die "$0 : failed to open output file '$fo' : $!\n";
select $O;
print "sample\tdatabase\tstrand\toverlap\tnumber\ttotal\tpercent\n";
foreach my $fi (@files) {
    my $bn = basename($fi);
    $bn =~ s/\.bed//;
    my @f = split /_/, $bn;
    my $num = `cat $fi | wc -l`;
    chomp($num);
    push @f, $num;
    push @f, $total;
    my $percent = sprintf( "%.4f", $num / $total * 100 );
    push @f, $percent;
    print join "\t", @f;
    print "\n";
}
close $O or warn "$0 : failed to close output file '$fo' : $!\n";
