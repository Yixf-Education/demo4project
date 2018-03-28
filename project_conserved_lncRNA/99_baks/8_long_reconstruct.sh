
source activate RNACocktail

date
run_rnacocktail.py long_align --long out/oases/HB01/transcripts.fa --outdir out --workdir work --threads 30 --sample HB01 --sam2psl $HOME/opt/fusioncatcher/bin/sam2psl.py --genome_dir 00_genome/star_hg38/

run_rnacocktail.py long_reconstruct --alignment out/hisat2/HB01/alignments.sorted.bam --short_junction out/hisat2/HB01/splicesites.bed --long_alignment out/starlong/HB01/Aligned.out.psl --outdir out --workdir work --idp /path/to/runIDP.py --threads 30 --sample HB01 --read_length 100 --ref_genome 00_genome/human/hg38.fa --ref_all_gpd hg19.all.refSeq_gencode_ensemble_EST_known.gpd --ref_gpd genes.GRCh37.refFlat.txt --idp_cfg idp.cfg
date

source deactivate RNACocktail
