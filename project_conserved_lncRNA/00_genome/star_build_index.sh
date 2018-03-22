#!/bin/bash

source activate RNACocktail

# human
doh="star_hg38"
mkdir $doh
STAR --runMode genomeGenerate --genomeDir $doh --genomeFastaFiles human/hg38.fa --runThreadN 30

# rat
dor="star_rn6"
mkdir $dor
STAR --runMode genomeGenerate --genomeDir $dor --genomeFastaFiles rat/rn6.fa --runThreadN 30

source deactivate RNACocktail
