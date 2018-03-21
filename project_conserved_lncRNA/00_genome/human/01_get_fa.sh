#!/bin/bash

source activate UCSC
twoBitToFa -seqList=hg38_chrs.txt hg38.2bit hg38.fa
faSize -detailed hg38.fa > hg38.size
source deactivate NCBI

#di="chrs"
#cat $di/chr1.fa $di/chr2.fa $di/chr3.fa $di/chr4.fa $di/chr5.fa $di/chr6.fa $di/chr7.fa $di/chr8.fa $di/chr9.fa $di/chr10.fa $di/chr11.fa $di/chr12.fa $di/chr13.fa $di/chr14.fa $di/chr15.fa $di/chr16.fa $di/chr17.fa $di/chr18.fa $di/chr19.fa $di/chr20.fa $di/chr21.fa $di/chr22.fa $di/chrX.fa $di/chrY.fa > hg38_cat.fa

source activate NGS
samtools faidx hg38.fa
samtools dict -a hg38 -s human -o hg38.dict hg38.fa
source deactivate NGS
