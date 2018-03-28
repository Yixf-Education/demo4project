
source activate RNACocktail
date
run_rnacocktail.py reconstruct --alignment_bam work/hisat2/HB01A/alignments.sorted.bam --outdir out --workdir work --threads 30 --sample HB01A
date

source deactivate RNACocktail
