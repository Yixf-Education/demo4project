#!/bin/bash

din="00_genes"
dia="05_identification/03_lncRNA"
do="07_lncRNA"
mkdir $do

dit="00_tools/ea-utils-1.04.807/clipper/"

grep -v "^#" $din/hg38_lncRNA.gtf > $do/hg38_lncRNA_all.gtf
grep -v "^#" $dia/HB_lncRNA.gtf >> $do/hg38_lncRNA_all.gtf
$dit/gtf2bed $do/hg38_lncRNA_all.gtf > $do/hg38_lncRNA_all.bed

grep -v "^#" $din/rn6_lncRNA.gtf > $do/rn6_lncRNA_all.gtf
grep -v "^#" $dia/RB_lncRNA.gtf >> $do/rn6_lncRNA_all.gtf
$dit/gtf2bed $do/rn6_lncRNA_all.gtf > $do/rn6_lncRNA_all.bed


