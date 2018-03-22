#!/bin/bash

di="02_fastq"
doo="03_denovo_out"
dow="03_denovo_work"

idx_human="00_genome/hisat2_hg38/hg38"
idx_rat="00_genome/hisat2_rn6/rn6"

cpus="30"

source activate RNACocktail

# human, PE
dih="$di/human"
fii="$di/human_brain.info"
hids=$(grep -v "id" $fii | cut -f1 | sort | uniq)
for hid in $hids
do
  run_rnacocktail.py align --align_idx $idx_human --outdir $doo --workdir $dow --1 $dih/${hid}_1.fastq --2 $dih/${hid}_2.fastq --threads $cpus --sample $hid
  run_rnacocktail.py reconstruct --alignment_bam $doo/hisat2/$hid/alignments.sorted.bam --outdir $doo --workdir $dow --threads $cpus --sample $hid
done

# rat, SE
dir="$di/rat"
fii="$di/rat_brain.info"
rids=$(grep -v "id" $fii | cut -f1 | sort | uniq)
for rid in $rids
do
  run_rnacocktail.py align --align_idx $idx_rat --outdir $doo --workdir $dow --U $dir/${rid}.fastq --threads $cpus --sample $rid
  run_rnacocktail.py reconstruct --alignment_bam $doo/hisat2/$rid/alignments.sorted.bam --outdir $doo --workdir $dow --threads $cpus --sample $rid
done


source deactivate RNACocktail
