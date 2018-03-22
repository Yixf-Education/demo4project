
source activate RNACocktail

date
run_rnacocktail.py denovo --1 02_fastq/human/HB01_1.fastq --2 02_fastq/human/HB01_2.fastq --outdir out --workdir work --threads 30 --sample HB01 --file_format fastq
date

source deactivate RNACocktail
