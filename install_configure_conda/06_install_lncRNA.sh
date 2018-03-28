#!/bin/bash

conda create -n lncRNA

source activate lncRNA

# For lncScore
conda install perl python=2.7 scikit-learn

conda install bedtools ea-utils cpat
# genometools-genometools gffutils ngsutils

source deactivate lncRNA
