#!/bin/bash

dio="04_merged"

sed '/>/ s/::.*$//' $dio/HB_merged.fa > $dio/HB_merged_candidates.fa
sed '/>/ s/::.*$//' $dio/RB_merged.fa > $dio/RB_merged_candidates.fa
