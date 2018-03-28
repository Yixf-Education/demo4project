#!/bin/bash

ls 03_guided_out/stringtie/HB*/transcripts.gtf > HB_gtfs.list
ls 03_denovo_out/stringtie/HB*/transcripts.gtf >> HB_gtfs.list

ls 03_guided_out/stringtie/RB*/transcripts.gtf > RB_gtfs.list
ls 03_denovo_out/stringtie/RB*/transcripts.gtf >> RB_gtfs.list

dom="04_merged"
mkdir $dom

source activate RNACocktail

stringtie --merge -p 30 -o $dom/HB_merged.gtf HB_gtfs.list
stringtie --merge -p 30 -o $dom/RB_merged.gtf RB_gtfs.list

source deactivate RNACocktail
