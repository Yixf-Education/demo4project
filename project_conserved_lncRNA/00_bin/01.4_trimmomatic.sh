#!/bin/bash

fi_info="00_info/SEQC_brain.txt"
di_fq="01_reads/fastq_merged"
do_fq="01_reads/fastq_clean"
mkdir $do_fq
do_up="01_reads/fastq_unpaired"
mkdir $do_up

source activate NGS

# human reads
hids=$(grep "_ILM_BGI_B" $fi_info | cut -f1 | sort | uniq)
for gsm in $hids
do
  fi_fq1="$di_fq/${gsm}_1.fastq"
  fi_fq2="$di_fq/${gsm}_2.fastq"
  fo_fq1="$do_fq/${gsm}_1.fastq"
  fo_fq2="$do_fq/${gsm}_2.fastq"
  fo_up1="$do_up/${gsm}_1.fastq"
  fo_up2="$do_up/${gsm}_2.fastq"
  trimmomatic PE -phred33 $fi_fq1 $fi_fq2 $fo_fq1 $fo_up1 $fo_fq2 $fo_up2 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 AVGQUAL:20
done

# rat reads
rids=$(grep "_Brn_" $fi_info | cut -f1 | sort | uniq)
for gsm in $rids
do
  fi_fq="$di_fq/${gsm}.fastq"
  fo_fq="$do_fq/${gsm}.fastq"
  trimmomatic SE -phred33 $fi_fq $fo_fq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 AVGQUAL:20
done

source activate NGS
