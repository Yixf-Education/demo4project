
source activate RNACocktail

date
run_rnacocktail.py long_align --long out/oases/HB01/transcripts.fa --outdir out --workdir work --threads 30 --sample HB01 --sam2psl $HOME/opt/fusioncatcher/bin/sam2psl.py --genome_dir 00_genome/star_hg38/
date

source deactivate RNACocktail
