#!/bin/bash

di="05_identification/03_lncRNA"
fi="$di/HB_lncRNA.bed"

did="00_database"
fig="$did/GENCODE/gencode_v27_lncRNA.bed"
fim="$did/MiTranscriptome/mitranscriptome.bed.gz"
do="06_vs_database"
mkdir $do

bedtools intersect -a $fi -b $fig -wa -u > $do/HB_GENCODE_noStrand_1bp.bed
bedtools intersect -a $fi -b $fig -wa -u -f 0.5 > $do/HB_GENCODE_noStrand_0.5.bed
bedtools intersect -a $fi -b $fig -wa -u -s > $do/HB_GENCODE_Strand_1bp.bed
bedtools intersect -a $fi -b $fig -wa -u -s -f 0.5 > $do/HB_GENCODE_Strand_0.5.bed

bedtools intersect -a $fi -b $fim -wa -u > $do/HB_MiTranscriptome_noStrand_1bp.bed
bedtools intersect -a $fi -b $fim -wa -u -f 0.5 > $do/HB_MiTranscriptome_noStrand_0.5.bed
bedtools intersect -a $fi -b $fim -wa -u -s > $do/HB_MiTranscriptome_Strand_1bp.bed
bedtools intersect -a $fi -b $fim -wa -u -s -f 0.5 > $do/HB_MiTranscriptome_Strand_0.5.bed
