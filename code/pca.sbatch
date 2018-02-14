#!/bin/bash

# This bash script illustrates how to automate the PCA steps on the
# RCC cluster (specifically, the "Broadwell" partition) using the
# SLURM job engine. Here we use multithreaded computation on 4 CPUs to
# speed up the computation of the principal components (PCs). Run this
# script with the following command:
#
#   sbatch pca.sbatch
# 
l
#SBATCH --partition=broadwl
#SBATCH --mem=10G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:10:00

# Get the phenotype specified as a command-line argument.
PHENOTYPE=${1}

# Specify the number of threads to use for the mclapply call.
NC=1

# For reproducibility, add version number to "module load" call.
module load R/3.4.3

# Set the number of threads used for matrix operations.
export OPENBLAS_NUM_THREADS=4

# Run the R script. Progress is reported to file pca.Rout.
R CMD BATCH --slave --no-save pca.R

