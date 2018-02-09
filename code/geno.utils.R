# Read an n x p genotype matrix from a .raw file, where n is the
# number of samples and p is the number of genetic markers (SNPs). See
# http://www.cog-genomics.org/plink2/formats#raw for more information
# about this file format.
read.geno.raw <- function (geno.file) {
  geno <- fread(geno.file,sep = " ",header = TRUE,stringsAsFactors = FALSE)
  class(geno) <- "data.frame"
  ids <- geno[["IID"]]
      markers <- geno$SNP
      geno    <- t(as.matrix(geno[-(1:6)]))
      rownames(geno) <- ids
      colnames(geno) <- markers
      mode(geno)     <- "double"
      return(geno)
  }
