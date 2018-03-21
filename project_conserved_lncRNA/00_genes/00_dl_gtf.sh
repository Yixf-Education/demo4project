#!/bin/bash

# human
wget -c ftp://ftp.ensembl.org/pub/release-91/gtf/homo_sapiens/Homo_sapiens.GRCh38.91.chr.gtf.gz
wget -c ftp://ftp.ensembl.org/pub/release-91/gff3/homo_sapiens/Homo_sapiens.GRCh38.91.chr.gff3.gz

# rat
wget -c ftp://ftp.ensembl.org/pub/release-91/gtf/rattus_norvegicus/Rattus_norvegicus.Rnor_6.0.91.chr.gtf.gz
wget -c ftp://ftp.ensembl.org/pub/release-91/gff3/rattus_norvegicus/Rattus_norvegicus.Rnor_6.0.91.chr.gff3.gz
