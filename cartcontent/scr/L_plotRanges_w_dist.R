# Function plotRanges 
## Build new plotting function that takes a list of ranges (list of exon ranges belonging to all transcripts (with expression + %) of a give gene), add highlighting for outersect and peptide
plotRanges <- function(g, z, gl) {
  # g <- "ENSG00000163283"
  # z <- enst_expr
  # gl <- gte_list
  if (!g %in% names(gl)) {
    stop("ENSG not in gte object")
  }
  library(ggplot2)
  library(IRanges)
  #load("~/Dropbox/Research/Projects/Ongoing/neoepitope_clonal_expression/data/ginfo.Rdata")
  source("cartcontent/scr/L_outersect.R")
  # source("outersect.R")
  x <- gl[[g]]
  z <- z[rownames(z) %in% names(x),]
  # z <- z[rowSums(z) > 0,]
  x <- x[rownames(z)]
  bins <- c()
  for(i in 1:length(x)) {
    bins <- append(bins, rep(i, nrow(as.data.frame(x[[i]]))))
  }
  tr <- cbind(as.data.frame(unlist(x)), bin = bins)
  # y <- outersect(x)
  # o <- cbind(as.data.frame(y), bin = rep(max(bins)+1))
  # k <- reduce(unlist(x))
  # r <- cbind(as.data.frame(k), bin = rep(max(bins)+2))
  p <- ggplot(tr) + 
    # geom_rect(data = r, aes(xmin = start, xmax = end, ymin = bin - 0.9, ymax = bin - 0.1, fill="dark blue")) +
    # geom_rect(data = o, aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, fill="red")) +
    geom_rect(aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, fill="dark grey")) +
    ggtitle("Transcript structures") +
    # ggtitle(paste0(g, " (", ginfo[ginfo$ENSG==g,]$symbol, ")")) +
    xlab(paste0("exons (", unique(ginfo[ginfo$ENSG==g,]$chromosome), " genomic coordinates)")) +
    scale_y_continuous(breaks = 1:(length(x))+0.5, labels= rownames(z), limits = c(0.9, length(x)+1.1), expand = c(0, 0)) + ## c(rep("", length(x)+1))
    ylab("Transcript") +
    scale_fill_manual(name = 'Coding regions', values =c('dark grey'='dark grey','dark blue'='dark blue','red'='red'), labels = c('constitutive coding regions','individual transcripts','variable coding regions')) +
    theme_bw() +
    theme(axis.ticks = element_blank(), legend.position = "none")
  return(p)
}