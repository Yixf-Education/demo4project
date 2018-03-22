#!/bin/bash

wget -c ftp://ftp.ensembl.org/pub/release-91/fasta/rattus_norvegicus/cdna/Rattus_norvegicus.Rnor_6.0.cdna.all.fa.gz

gzip -dc Rattus_norvegicus.Rnor_6.0.cdna.all.fa.gz > rn6.cdna.fa
