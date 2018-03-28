#!/bin/bash

dit="00_tools/lncScore-1.0.2"
# dit="00_tools/lncScore"
di="04_merged"
do="05_identification"
mkdir $do
doo="$do/01_lncScore"
mkdir $doo

source activate lncRNA

#python $dit/lncScore.py -f $di/HB_merged_candidates.fa -g $di/HB_merged.gtf -o $doo/HB_lncScore.txt -p 1 -x $dit/dat/Human_Hexamer.tsv -t $dit/dat/Human_training.dat
#mv inputfile.fasta $do/HB_inputfile.fa

python $dit/lncScore.py -f $di/RB_merged_candidates.fa -g $di/RB_merged.gtf -o $doo/RB_lncScore.txt -p 1 -x $dit/dat/Mouse_Hexamer.tsv -t $dit/dat/Mouse_training.dat
#mv inputfile.fasta $do/RB_inputfile.fa

source deactivate lncRNA
