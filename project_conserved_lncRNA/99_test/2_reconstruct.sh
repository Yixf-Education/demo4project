
source activate RNACocktail
date
run_rnacocktail.py reconstruct --alignment_bam work/hisat2/HB01/alignments.sorted.bam --outdir out --workdir work --ref_gtf 00_genes/hg38.gtf --threads 30 --sample HB01
date

source deactivate RNACocktail
