#!/bin/bash

wget -c ftp://ftp.ensembl.org/pub/release-91/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz

gzip -dc Homo_sapiens.GRCh38.cdna.all.fa.gz > hg38.cdna.fa
