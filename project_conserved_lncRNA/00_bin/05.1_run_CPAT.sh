#!/bin/bash

dit="00_tools/CPAT-1.2.4"
di="04_merged"
do="05_identification"
mkdir $do
doo="$do/01_CPAT"
mkdir $doo

source activate lncRNA

cpat.py -g $di/HB_merged_candidates.fa -d $dit/dat/Human_logitModel.RData -x $dit/dat/Human_Hexamer.tsv -o $doo/HB_CPAT.txt
cpat.py -g $di/RB_merged_candidates.fa -d $dit/dat/Mouse_logitModel.RData -x $dit/dat/Mouse_Hexamer.tsv -o $doo/RB_CPAT.txt

source deactivate lncRNA
