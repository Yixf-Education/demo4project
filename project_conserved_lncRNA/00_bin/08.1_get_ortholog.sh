#!/bin/bash

dic="00_chains"

di="07_lncRNA"
do="08_ortholog"
mkdir $do

source activate lncRNA

liftOver $di/hg38_lncRNA_all.bed $dic/hg38ToRn6.over.chain.gz $do/lncRNA_hg38_to_rn6.bed $do/lncRNA_hg38_to_rn6.unmapped

bedtools intersect -a $do/lncRNA_hg38_to_rn6.bed -b $di/rn6_lncRNA_all.bed -wa -wb > $do/ortholog_hg38_rn6_noStrand.txt
bedtools intersect -a $do/lncRNA_hg38_to_rn6.bed -b $di/rn6_lncRNA_all.bed -wa -wb -s > $do/ortholog_hg38_rn6_Strand.txt

source deactivate lncRNA

