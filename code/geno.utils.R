# Colors and shapes used in the PC plots.
colors <- c(rep(c("#E69F00","#56B4E9","#009E73","#F0E442","#0072B2",
                  "#D55E00","#CC79A7"),length.out = 21),"black")
shapes <- c(rep(c(19,17,8,1,3),length.out = 21),19)

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
  ids    <- sapply(strsplit(rownames(pcs),"_"),function (x) x[2])
  labels <- subset(labels,is.element(labels$id,ids))
  rows   <- match(labels$id,ids)
  pcs[rows,"label"] <- as.character(labels$pop)
  pops   <- sort(unique(as.character(pcs$label)))
  pops   <- c(setdiff(pops,"none"),"none")
  return(transform(pcs,label = factor(label,pops)))
}

# This is a basic PC plot---it shows the projection of the samples
# onto 2 selected PCs.
basic.pc.plot <- function (dat, x = "PC1", y = "PC2", size = 2)
  ggplot(as.data.frame(dat),aes_string(x = x,y = y),
         environment = environment()) +
    geom_point(color = "royalblue",shape = 20,size = size) +
    theme_cowplot() +
    theme(axis.line = element_blank())

# This is a labeled PC plot---it shows the project of the samples onto
# 2 selected PCs, and varies the color and shape of the points
# according to their labels (this should be a factor, i.e. a
# categorical variable).
labeled.pc.plot <- function (dat, x = "PC1", y = "PC2", label = "label",
                             size = 2)
  ggplot(as.data.frame(dat),
         aes_string(x = x,y = y,color = "label",shape = "label"),
         environment = environment()) +
    geom_point(size = size) +
    scale_color_manual(values = colors) +
    scale_shape_manual(values = shapes) +
    theme_cowplot() +
    theme(axis.line = element_blank())

# This does the same thing as labeled.pc.plot, but also shows the ids
# of the unlabeled samples.
labeled.pc.plot2 <- function (dat, x = "PC1", y = "PC2", label = "label",
                              size = 2) {
  dat  <- as.data.frame(dat)
  ids  <- sapply(strsplit(rownames(pcs),"_"),function (x) x[2])
  dat  <- cbind(dat,data.frame(id = paste(" ",ids)))
  rows <- which(dat[[label]] != "none")
  dat1 <- dat[rows,]
  dat2 <- dat[-rows,]
  return(ggplot(environment = environment()) +
         geom_point(data = dat1,size = size,
                    mapping = aes_string(x = x,y = y,color = "label",
                                         shape = "label")) +
         scale_color_manual(values = colors) +
         scale_shape_manual(values = shapes) +
         geom_point(data = dat2,mapping = aes_string(x = x,y = y),
                    color = "black",shape = 19,size = size,
                    show.legend = FALSE) +
         geom_text(data = dat2,mapping = aes_string(x = x,y = y,label = "id"),
                   color = "black",size = size,hjust = 0,vjust = 1,
                   show.legend = FALSE) +
         theme_cowplot() +
         theme(axis.line = element_blank()))
}
