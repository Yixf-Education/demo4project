
source activate RNACocktail
date
run_rnacocktail.py align --align_idx 00_genome/hisat2_hg38/hg38 --outdir out --workdir work --ref_gtf 00_genes/hg38.gtf --1 02_fastq/human/HB01_1.fastq --2 02_fastq/human/HB01_2.fastq --threads 30 --sample HB01
date


source deactivate RNACocktail
