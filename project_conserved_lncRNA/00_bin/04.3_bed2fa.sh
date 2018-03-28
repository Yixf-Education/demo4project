#!/bin/bash

dif="00_genome"
dio="04_merged"

source activate lncRNA

bedtools getfasta -fi $dif/human/hg38.fa -bed $dio/HB_merged.bed -s -name+ > $dio/HB_merged.fa
bedtools getfasta -fi $dif/rat/rn6.fa -bed $dio/RB_merged.bed -s -name+ > $dio/RB_merged.fa

source deactivate lncRNA
