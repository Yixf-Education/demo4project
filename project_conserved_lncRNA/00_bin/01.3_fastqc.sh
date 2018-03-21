#!/bin/bash

dio="01_reads"
di_fastq="$dio/fastq_merged"
do_fastqc="$dio/fastqc_raw"
mkdir $do_fastqc

source activate NGS
fastqc -o $do_fastqc -t 50 $di_fastq/*.fastq
source deactivate NGS

