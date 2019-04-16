# Script to reproduce the PCA analysis of 1000 Genomes data. This
# script should be run from the "genetic-data-analysis-1" folder.

# Load the data.table and rsvd R packages, and some functions I wrote
# specifically for this analysis.
suppressMessages(library(data.table))
library(rsvd)
source("functions.R")

# Load the genotype matrix into R.
cat("Loading genotype matrix.\n")
geno <- read.geno.raw("1kg_recoded.raw")

# Fill in the missing genotypes.
cat("Filling in missing genotypes.\n")
p <- ncol(geno)
for (j in 1:p) {
  i         <- which(is.na(geno[,j]))
  geno[i,j] <- mean(geno[,j],na.rm = TRUE)
}

# Compute PCs using rsvd package.
cat("Computing first 10 PCs.\n")
out.pca       <- rpca(geno,k = 10,center = TRUE,scale = FALSE,retx = TRUE)
pcs           <- out.pca$x
colnames(pcs) <- paste0("PC",1:10)
summary(out.pca)

# Save PCA results.
cat("Saving results to file.\n")
save(file = "1kg_pca.RData",list = c("out.pca","pcs"))
