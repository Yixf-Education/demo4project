#!/bin/bash

# Reference:
# https://mirror.tuna.tsinghua.edu.cn/help/anaconda/
# Set up channels

conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/

# Conda Forge
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
# R
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r/
# bioconda
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/


conda config --set show_channel_urls yes
