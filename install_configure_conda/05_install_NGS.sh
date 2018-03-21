#!/bin/bash

conda create -n NGS

source activate NGS

conda install samtools fastqc trimmomatic

source deactivate NGS
