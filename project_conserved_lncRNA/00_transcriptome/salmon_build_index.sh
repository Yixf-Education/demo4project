#!/bin/bash

source activate RNACocktail

# human
doh="salmon_hg38"
mkdir $doh
salmon index -t human/hg38.cdna.fa -i $doh --type fmd -p 30

# rat
dor="salmon_rn6"
mkdir $dor
salmon index -t rat/rn6.cdna.fa -i $dor --type fmd -p 30

source deactivate RNACocktail
