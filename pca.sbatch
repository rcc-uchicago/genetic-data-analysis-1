#!/bin/bash

# This bash script illustrates how to automate the PCA steps on
# midway2 (specifically, the "Broadwell" partition) using Slurm.
# Multithreaded computation on 4 CPUs is used here to speed up the
# computation of the principal components (PCs). Run this script with
# the following command:
#
#   sbatch pca.sbatch
# 

#SBATCH --partition=broadwl
#SBATCH --mem=19G
#SBATCH --cpus-per-task=8
#SBATCH --time=00:15:00

# For reproducibility, I add a version number to "module load" call.
module load R/3.6.1

# Set the number of threads used for matrix operations.
export OPENBLAS_NUM_THREADS=4

# Run the R script. Progress is reported to file pca.out.
Rscript pca.R > pca.out
