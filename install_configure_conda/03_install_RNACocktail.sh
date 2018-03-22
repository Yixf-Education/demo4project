#!/bin/bash

# https://bioinform.github.io/rnacocktail/

conda create -n RNACocktail

source activate RNACocktail

# Python2
conda install python=2

# Dependencies
conda install pybedtools pysam numpy scipy biopython openpyxl pandas xlrd

# Tools
conda install samtools hisat2 stringtie salmon oases velvet subread lordec star gatk picard htslib bowtie bowtie2 bwa sra-tools coreutils pigz blat ucsc-fatotwobit ucsc-liftover seqtk gmap

# Packages
conda install bioconductor-deseq2 bioconductor-tximport

# Use R to install readr

# FusionCatcher: RNA Fusion detection
wget http://sf.net/projects/fusioncatcher/files/bootstrap.py -O bootstrap.py && python bootstrap.py -t --download
# "Y" for every question except the installing path: $HOME/opt/fusioncatcher

# Tools are not installed!
# IDP: Long-read transcriptome reconstruction
# IDP-fusion: Long-read fusion detection
# GIREMI: RNA editing detection
# gatb-core

# RNACocktail
pip install https://github.com/bioinform/RNACocktail/archive/v0.2.2.tar.gz

source deactivate RNACocktail
