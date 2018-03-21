#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my $di = "01_reads/fastq_clean";

my $do = "02_fastq";
mkdir $do unless -d $do;

my $doh = "$do/human";
mkdir $doh unless -d $doh;

my $dor = "$do/rat";
mkdir $dor unless -d $dor;

my ( %human, %rat );
my ( $cnt_human, $cnt_rat ) = 0;
my $dii = "00_info";
my $fi  = "$dii/SEQC_brain.txt";
open my $I, '<', $fi or die "$0 : failed to open input file '$fi' : $!\n";
while (<$I>) {
    chomp;
    my @f = split /\t/;
    if ( $f[1] =~ /_ILM_BGI_B_(\d)_/ ) {
        $cnt_human++;
        $cnt_human = sprintf( "%02d", $cnt_human );
        my $hid = "HB$cnt_human";
        $human{$hid} = "$f[0]\t$1";
        link( "$di/$f[0]_1.fastq", "$doh/${hid}_1.fastq" );
        link( "$di/$f[0]_2.fastq", "$doh/${hid}_2.fastq" );
    }
    if ( $f[1] =~ /Brn_([FM])_(\d{3})_(\d)/ ) {
        $cnt_rat++;
        $cnt_rat = sprintf( "%02d", $cnt_rat );
        my $rid = "RB$cnt_rat";
        $rat{$rid} = "$f[0]\t$1\t$2\t$3";
        link( "$di/$f[0].fastq", "$dor/${rid}.fastq" );
    }
}
close $I or warn "$0 : failed to close input file '$fi' : $!\n";

my $foh = "$do/human_brain.info";
open my $OH, '>', $foh or die "$0 : failed to open output file '$foh' : $!\n";
select $OH;
print "id\tgsm\tsample\n";
foreach my $hid ( sort keys %human ) {
    print "$hid\t$human{$hid}\n";
}
close $OH or warn "$0 : failed to close output file '$foh' : $!\n";

my $for = "$do/rat_brain.info";
open my $OR, '>', $for or die "$0 : failed to open output file '$for' : $!\n";
select $OR;
print "id\tgsm\tgender\tmonth\trep\n";
foreach my $rid ( sort keys %rat ) {
    print "$rid\t$rat{$rid}\n";
}
close $OR or warn "$0 : failed to close output file '$for' : $!\n";

