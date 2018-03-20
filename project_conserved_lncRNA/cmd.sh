#!/bin/bash

# Download reads from GEO/SRA database
source activate NCBI
nohup 00_bin/00.1_gsm2srr2fq.sh -d 01_reads/human -i 00_info/SEQC_human_brain.txt > 01_reads/human/download.log 2>&1 &
nohup 00_bin/00.1_gsm2srr2fq.sh -d 01_reads/rat -i 00_info/SEQC_rat_brain.txt > 01_reads/rat/download.log 2>&1 &
source deactivate NCBI

# Merge to get final FASTQ files
nohup 00_bin/00.2_multi2one_srr2gsm.sh -d 01_reads/human  > 01_reads/human/merge.log 2>&1 &
nohup 00_bin/00.2_multi2one_srr2gsm.sh -d 01_reads/rat  > 01_reads/rat/merge.log 2>&1 &
