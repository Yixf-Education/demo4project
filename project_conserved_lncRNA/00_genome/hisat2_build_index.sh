#!/bin/bash

source activate RNACocktail

# human
doh="hisat2_hg38"
mkdir $doh
hisat2-build -p 30 human/hg38.fa $doh/hg38

# rat
dor="hisat2_rn6"
mkdir $dor
hisat2-build -p 30 rat/rn6.fa $dor/rn6

source deactivate RNACocktail
