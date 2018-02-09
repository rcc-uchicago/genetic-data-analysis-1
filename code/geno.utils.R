# Read an n x p genotype matrix from a .raw file, where n is the
# number of samples and p is the number of genetic markers (SNPs). See
# http://www.cog-genomics.org/plink2/formats#raw for more information
# about this file format.
read.geno.raw <- function (geno.file) {
  geno <- fread(geno.file,sep = " ",header = TRUE,stringsAsFactors = FALSE)
  class(geno)    <- "data.frame"
  ids            <- with(geno,paste(FID,IID,sep = "_"))
  geno           <- geno[-(1:6)]
  rownames(geno) <- ids
  geno           <- as.matrix(geno)
  storage.mode(geno) <- "double"
  return(geno)
}
