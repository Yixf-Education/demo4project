#!/bin/bash

dit="../../00_tools/ea-utils-1.04.807/clipper/"

$dit/gtf2bed gencode.v27.long_noncoding_RNAs.gtf.gz > gencode_v27_lncRNA.bed
