#!/bin/bash

# human
wget -c ftp://ftp.ensembl.org/pub/release-91/fasta/homo_sapiens/pep/Homo_sapiens.GRCh38.pep.all.fa.gz
wget -c ftp://ftp.ensembl.org/pub/release-91/fasta/homo_sapiens/ncrna/Homo_sapiens.GRCh38.ncrna.fa.gz

# rat
wget -c ftp://ftp.ensembl.org/pub/release-91/fasta/rattus_norvegicus/pep/Rattus_norvegicus.Rnor_6.0.pep.all.fa.gz
wget -c ftp://ftp.ensembl.org/pub/release-91/fasta/rattus_norvegicus/ncrna/Rattus_norvegicus.Rnor_6.0.ncrna.fa.gz
