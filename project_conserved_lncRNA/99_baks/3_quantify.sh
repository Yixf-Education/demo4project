
source activate RNACocktail
date
run_rnacocktail.py quantify --quantifier_idx 00_transcriptome/salmon_hg38 --1 02_fastq/human/HB01_1.fastq --2 02_fastq/human/HB01_2.fastq --libtype IU --salmon_k 19 --outdir out --workdir work --threads 30 --sample HB01
date

source deactivate RNACocktail
