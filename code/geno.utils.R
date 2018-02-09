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

# Add labels to the PC data. Here I assume the row names of "pcs" are
# of the form X_Y, where X is the family id and Y is the individual
# id, and there is an "id" column in the "labels" data.frame giving
# the individual ids. The labels are stored in the "pop" column of the
# "labels" data frame.
add.poplabels <- function (pcs, labels) {
  pcs    <- as.data.frame(pcs)
  pcs    <- cbind(label = "none",pcs,stringsAsFactors = FALSE)
  ids    <- sapply(strsplit(rownames(pcs),"_"),function (x) x[1])
  labels <- subset(labels,is.element(labels$id,ids))
  rows   <- match(labels$id,ids)
  pcs[rows,"label"] <- as.character(labels$pop)
  return(transform(pcs,label = factor(label)))
}

# This is a basic PC plot---it shows the projection of the samples
# onto 2 selected PCs.
basic.pc.plot <- function (dat, x = "PC1", y = "PC2")
  ggplot(as.data.frame(dat),aes_string(x = x,y = y)) +
    geom_point(color = "royalblue",shape = 20,size = 2.5) +
    theme_cowplot() +
    theme(axis.line = element_blank())

labeled.pc.plot <- function (dat, x = "PC1", y = "PC2",label = "label") {
  colors <- c(rep(c("#E69F00","#56B4E9","#009E73","#F0E442","#0072B2",
                    "#D55E00","#CC79A7"),length.out = 21),"black")
  shapes <- c(rep(c(19,17,8,1,3),length.out = 21),19)
  return(ggplot(as.data.frame(dat),
                aes_string(x = x,y = y,color = "label",shape = "label")) +
         geom_point(size = 3) +
         scale_color_manual(values = colors) +
         scale_shape_manual(values = shapes) +
         theme_cowplot() +
         theme(axis.line = element_blank()))
}
  
