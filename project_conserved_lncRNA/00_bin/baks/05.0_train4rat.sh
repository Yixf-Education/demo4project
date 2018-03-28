#!/bin/bash

dit="00_tools/lncScore-1.0.2"
do="05_lncScore"
mkdir $do
doo="$do/00_rat_training"
mkdir $doo

wd=$(pwd)

cd $doo
wget -c ftp://ftp.ensembl.org/pub/release-91/fasta/rattus_norvegicus/pep/Rattus_norvegicus.Rnor_6.0.pep.all.fa.gz
gunzip Rattus_norvegicus.Rnor_6.0.pep.all.fa.gz
wget -c ftp://ftp.ensembl.org/pub/release-91/fasta/rattus_norvegicus/ncrna/Rattus_norvegicus.Rnor_6.0.ncrna.fa.gz
gunzip Rattus_norvegicus.Rnor_6.0.ncrna.fa.gz
wget -c ftp://ftp.ensembl.org/pub/release-91/gtf/rattus_norvegicus/Rattus_norvegicus.Rnor_6.0.91.gtf.gz
gunzip Rattus_norvegicus.Rnor_6.0.91.gtf.gz
cd $wd

source activate lncRNA

python $dit/tools/make_TrainingDat.py -m $doo/Rattus_norvegicus.Rnor_6.0.pep.all.fa -l $doo/Rattus_norvegicus.Rnor_6.0.ncrna.fa -g $doo/Rattus_norvegicus.Rnor_6.0.91.gtf -o $doo/Rat_training.dat -p 1 -x $dit/dat/Rat_Hexamer.tsv

source deactivate lncRNA
