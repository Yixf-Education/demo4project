#!/bin/bash

source activate UCSC
twoBitToFa -seqList=rn6_chrs.txt rn6.2bit rn6.fa
faSize -detailed rn6.fa > rn6.size
source deactivate NCBI

source activate NGS
samtools faidx rn6.fa
samtools dict -a rn6 -s rat -o rn6.dict rn6.fa
source deactivate NGS
