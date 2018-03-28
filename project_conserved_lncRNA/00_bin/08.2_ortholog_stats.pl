#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use File::Basename;

my $dio = "08_ortholog";

my $fo = "$dio/ortholog.stats";
open my $O, '>', $fo or die "$0 : failed to open output file '$fo' : $!\n";
select $O;
print
  "strand\tnewlyHuman\tknownHuman\ttotalHuman\tnewlyRat\tknownRat\ttotalRat\n";
my @files = glob "$dio/*.txt";
foreach my $fi (@files) {
    my @f  = ();
    my $bn = basename($fi);
    my $s  = $bn =~ /noStrand/ ? "noStrand" : "strand";
    push @f, $s;
    my $nh = `cut -f4 $fi | sort | uniq | grep "MSTRG" | wc -l`;
    chomp($nh);
    push @f, $nh;
    my $kh = `cut -f4 $fi | sort | uniq | grep "ENS" | wc -l`;
    chomp($kh);
    push @f, $kh;
    my $th = $nh + $kh;
    push @f, $th;
    my $nr = `cut -f16 $fi | sort | uniq | grep "MSTRG" | wc -l`;
    chomp($nr);
    push @f, $nr;
    my $kr = `cut -f16 $fi | sort | uniq | grep "ENS" | wc -l`;
    chomp($kr);
    push @f, $kr;
    my $tr = $nr + $kr;
    push @f, $tr;
    print join "\t", @f;
    print "\n";
}
close $O or warn "$0 : failed to close output file '$fo' : $!\n";

