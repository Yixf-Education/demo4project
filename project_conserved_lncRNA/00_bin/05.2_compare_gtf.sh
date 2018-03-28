#!/bin/bash

dir="00_genes"
dim="04_merged"
do="05_identification"
doc="$do/02_compare"
mkdir $doc

source activate lncRNA

gffcompare -R -r $dir/hg38_PCG.gtf -o $doc/HB $dim/HB_merged.gtf
gffcompare -R -r $dir/rn6_PCG.gtf -o $doc/RB $dim/RB_merged.gtf

source deactivate lncRNA
