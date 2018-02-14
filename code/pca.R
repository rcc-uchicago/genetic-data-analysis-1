# Script to reproduce the PCA analysis of the combined 1000 Genomes +
# Human Origins data set. This script should be run from the "code"
# folder. See "run PCA on combined data set" in the slides for more
# information.

# Load the data.table and rsvd R packages, and some functions I wrote
# specifically for this analysis.
suppressMessages(library(data.table))
library(rsvd)
source("geno.utils.R")

# Load the genotype matrix into R.
cat("Loading genotype matrix.\n")
geno <- read.geno.raw("../data/1kg_origins_recoded.raw")

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
save(file = "../output/1kg_origins_pca.RData",
     list = c("out.pca","pcs"))

