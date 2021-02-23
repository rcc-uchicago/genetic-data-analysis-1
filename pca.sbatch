#!/bin/bash

# This bash script illustrates how to automate the PCA steps on
# midway2 (specifically, the "Broadwell" partition) using Slurm. Run
# this script with the following command:
#
#   sbatch pca.sbatch
# 

#SBATCH --partition=broadwl
#SBATCH --mem=19G
#SBATCH --cpus-per-task=8
#SBATCH --time=00:15:00

# For reproducibility, I add a version number to "module load" call.
module load R/3.6.1

# Run the R script. Progress is reported to file pca.out.
Rscript pca.R > pca.out
