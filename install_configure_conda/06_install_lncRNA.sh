#!/bin/bash

conda create -n lncRNA

source activate lncRNA

# For lncScore
conda install perl python=2.7 scikit-learn

conda install ngsutils genometools-genometools gffutils

source deactivate lncRNA
