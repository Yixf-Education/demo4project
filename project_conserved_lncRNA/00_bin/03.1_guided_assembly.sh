#!/bin/bash

di="02_fastq"
doo="03_guided_out"
dow="03_guided_work"

idx_human="00_genome/hisat2_hg38/hg38"
gtf_human="00_genes/hg38.gtf"
idx_rat="00_genome/hisat2_rn6/rn6"
gtf_rat="00_genes/rn6.gtf"

cpus="30"

source activate RNACocktail

# human, PE
dih="$di/human"
fii="$di/human_brain.info"
hids=$(grep -v "id" $fii | cut -f1 | sort | uniq)
for hid in $hids
do
  run_rnacocktail.py align --align_idx $idx_human --outdir $doo --workdir $dow --ref_gtf $gtf_human --1 $dih/${hid}_1.fastq --2 $dih/${hid}_2.fastq --threads $cpus --sample $hid
  run_rnacocktail.py reconstruct --alignment_bam $doo/hisat2/$hid/alignments.sorted.bam --outdir $doo --workdir $dow --ref_gtf $gtf_human --threads $cpus --sample $hid
done

# rat, SE
dir="$di/rat"
fii="$di/rat_brain.info"
rids=$(grep -v "id" $fii | cut -f1 | sort | uniq)
for rid in $rids
do
  run_rnacocktail.py align --align_idx $idx_rat --outdir $doo --workdir $dow --ref_gtf $gtf_rat --U $dir/${rid}.fastq --threads $cpus --sample $rid
  run_rnacocktail.py reconstruct --alignment_bam $doo/hisat2/$rid/alignments.sorted.bam --outdir $doo --workdir $dow --ref_gtf $gtf_rat --threads $cpus --sample $rid
done


source deactivate RNACocktail
