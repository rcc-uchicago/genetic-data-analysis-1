# Read an n x p genotype matrix from a .raw file, where n is the
# number of samples and p is the number of genetic markers (SNPs). See
# http://www.cog-genomics.org/plink2/formats#raw for more information
# about this file format.
read.geno.raw <- function (geno.file) {
  geno <- fread(geno.file,sep = " ",header = TRUE,stringsAsFactors = FALSE,
                showProgress = FALSE)
  class(geno)    <- "data.frame"
  ids            <- with(geno,paste(FID,IID,sep = "_"))
  geno           <- geno[-(1:6)]
  rownames(geno) <- ids
  geno           <- as.matrix(geno)
  storage.mode(geno) <- "double"
  return(geno)
}

# This is a basic PC plot---it shows the projection of the samples
# onto 2 selected PCs.
basic.pc.plot <- function (pca, x = "PC1", y = "PC2", size = 2)
  ggplot(as.data.frame(pca$x),aes_string(x = x,y = y),
         environment = environment()) +
    geom_point(color = "darkblue",shape = 20,size = size,na.rm = TRUE) +
    labs(x = sprintf("%s (%0.1f%%)",x,100*summary(pca)[3,x]),
         y = sprintf("%s (%0.1f%%)",y,100*summary(pca)[3,y])) +
    theme_cowplot(font_size = 12) +
    theme(axis.line = element_blank())

# This is a labeled PC plot---it shows the project of the samples onto
# 2 selected PCs, and varies the color and shape of the points
# according to their labels (this should be a factor, i.e. a
# categorical variable).
labeled.pc.plot <- function (pca, labels, x = "PC1", y = "PC2",
                             label = "label", size = 2) {
  colors <- rep(c("#E69F00","#56B4E9","#009E73","#F0E442","#0072B2",
                  "#D55E00","#CC79A7"),length.out = 28)
  shapes <- rep(c(19,17,8,3),length.out = 28)
  dat <- as.data.frame(pca$x)
  dat$label <- labels
  return(ggplot(dat,
                aes_string(x = x,y = y,color = "label",shape = "label"),
                environment = environment()) +
         geom_point(size = size,na.rm = TRUE) +
         scale_color_manual(values = colors) +
         scale_shape_manual(values = shapes) +
         labs(x = sprintf("%s (%0.1f%%)",x,100*summary(pca)[3,x]),
              y = sprintf("%s (%0.1f%%)",y,100*summary(pca)[3,y])) +
         theme_cowplot() +
         theme(axis.line = element_blank()))
}
