#!/bin/bash

# Download reads from GEO/SRA database
source activate NCBI
nohup 00_bin/01.1_gsm2srr2fq.sh -d 01_reads -i 00_info/SEQC_brain.txt > 01_reads/download.log 2>&1 &
source deactivate NCBI
# Merge to get final FASTQ files
nohup 00_bin/01.2_multi2one_srr2gsm.sh -d 01_reads  > 01_reads/merge.log 2>&1 &

# FastQC all raw reads
bash 00_bin/01.3_fastqc_raw.sh
# Trim and filter reads
nohup bash 00_bin/01.4_trimmomatic.sh > 01_reads/trimmomatic.log 2>&1 &
# FastQC all raw reads
bash 00_bin/01.5_fastqc_clean.sh
