# Script to reproduce the PCA analysis of 1000 Genomes data. This
# script should be run from the "genetic-data-analysis-1" folder.

# Load the data.table and rsvd R packages, and some functions I wrote
# specifically for this analysis.
library(data.table)
library(rsvd)
source("functions.R")

# Load the genotype matrix into R.
geno <- read.geno.raw("1kg_recoded.raw")

# Fill in the missing genotypes.
p <- ncol(geno)
for (j in 1:p) {
  i         <- which(is.na(geno[,j]))
  geno[i,j] <- mean(geno[,j],na.rm = TRUE)
}

# Compute top two PCs using rsvd package.
pca <- rpca(geno,k = 2,center = TRUE,scale = FALSE,retx = TRUE)

# Save PCA results.
save(file = "1kg_pca.RData",list = "pca")
