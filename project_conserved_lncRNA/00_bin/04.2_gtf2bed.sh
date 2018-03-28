#!/bin/bash

dit="00_tools/ea-utils-1.04.807/clipper/"
dio="04_merged"

$dit/gtf2bed $dio/HB_merged.gtf > $dio/HB_merged.bed
$dit/gtf2bed $dio/RB_merged.gtf > $dio/RB_merged.bed
