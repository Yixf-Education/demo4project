#!/bin/bash

# Create a new environment
conda create -n NCBI

# 1. Activate the enviroment
source activate NCBI

# 2. Install softwares
conda install entrez-direct sra-tools

# 3. Deactivate the enviroment
source deactivate NCBI
