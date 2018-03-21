#!/bin/bash

conda create -n UCSC

source activate UCSC

conda install ucsc-twobittofa ucsc-fasize

source deactivate UCSC
