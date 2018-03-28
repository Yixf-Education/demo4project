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

# Gather and rename FASTQs
perl 00_bin/02_ln_reads.pl

# Assembly: guided
nohup bash 00_bin/03.1_guided_assembly.sh > assembly_guided.log 2>&1 &
# Assembly: de novo
nohup bash 00_bin/03.2_denovo_assembly.sh > assembly_denovo.log 2>&1 &

# Merge assembly transcripts
nohup bash 00_bin/04.1_merge_gtf.sh &

# Convert transcripts in GTF to BED
bash 00_bin/04.2_gtf2bed.sh

# Extract transcripts sequences from BED and genome
bash 00_bin/04.3_bed2fa.sh
bash 00_bin/04.4_simple_fa.sh

# Calculate coding pontential
#bash 00_bin/05.1_run_lncScore.sh
bash 00_bin/05.1_run_CPAT.sh

# Compare with protein-coding genes in GTF format
bash 00_bin/05.2_compare_gtf.sh

# Get final lncRNA
perl 00_bin/05.3.1_get_lncRNA_IDs.pl
perl 00_bin/05.3.2_get_lncRNA_gtf_bed.pl

# Compare with databases: GENCODE & MiTranscriptome
bash 00_bin/06.1_vs_database.sh
perl 00_bin/06.2_vs_stats.pl

# Combine lncRNAs from known and assembly lncRNA
bash 00_bin/07.1_combine_lncRNA_known_assembly.sh
