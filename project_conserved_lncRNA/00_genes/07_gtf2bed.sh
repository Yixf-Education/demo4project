#!/bin/bash

dit="../00_tools/ea-utils-1.04.807/clipper/"

$dit/gtf2bed hg38_lncRNA.gtf > hg38_lncRNA.bed
$dit/gtf2bed rn6_lncRNA.gtf > rn6_lncRNA.bed
