# CREATION OF TRANSCRIPTS LEVEL BOXPLOT. 

# GOAL: for each gene, to create a set of boxplots with the transcript 
# level of each isoform. 

# import of the files: 
# - "expr_sub.Rdata": it contains two tables. 
#     1. ensg_expr: genes on the rows. On the columns there are the TCGA cancers 
# and the corresponding normal tissue from GTEX.This table contains the 33 genes 
# that are used as targets for cancers with a correspondence in TCGA
#     2. enst_expr: transcripts (of the different gene isoforms) on the rows. 
# On the columns there are the TCGA cancers and the corresponding normal
# tissues from GTEX. 
# - "pheno.rds": table mapping each TCGA or GTEX sample to the corresponing 
# cancer/tissue (category)
# - "gte.Rdata" list with all the transcripts for each gene. It also contains 
# genomic coordinates. 

library(tidyverse)
library(janitor)
library(wesanderson)
library(biomaRt)

load(file = "cartcontent/data/expr_sub.Rdata")
load(file = "cartcontent/data/gte.Rdata")
pheno <- read_rds("cartcontent/data/pheno.rds")

enst_expr <- enst_expr %>% 
  rownames_to_column()
enst_expr <- as_tibble(enst_expr)

list_of_categories <- unique(pheno$TCGA_GTEX_main_category)

# retrieve the haematological cancer categories since we decided to exclude them from the analyses
haematological_cancers <- c("blood", "diffuse large b-cell lymphoma", "acute myeloid leukemia" )

pheno_nh <- pheno[!(pheno$TCGA_GTEX_main_category %in% haematological_cancers), ] # removal of the hematological cancers

# note: not all the transcripts listed in gte_list are in the enst_expr table. 
# In the plots I am retaining the transcripts that are present in both tables. 

# find the gene in ensg_exp with the highest number of isoforms in order to 
# decide the dimensions of the boxplot

l <- vector(mode = "numeric", length = nrow(ensg_expr))
for(i in 1:nrow(ensg_expr)) {
  ensg <- rownames(ensg_expr)[i]
  l[i] <- length(names(gte_list[[ensg]]))
  
  maxl <- (max(l))
  
}

maxl

# create a boxplot function to have for each gene the expression level of all the isoforms 
# in all the tissues 

# conversion of the ensg id into gene symbols. In the website there will be gene symbols, not ensg id.
mart1 <- useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl")

hgnc_from_ensembl <- getBM(attributes = c("ensembl_gene_id","hgnc_symbol"), 
                            filters = "ensembl_gene_id", 
                            mart = mart1, 
                            values = rownames(ensg_expr))

hgnc_from_ensembl[33,2] <- "CEA" # the hgcn for the ensgID ENSG00000267881 is not in biomart, 
# so I am adding it manually

# creating the boxplot function (goal)
boxplot_isoforms_all_tissues <- function(hgnc) {
 
  #retrieve the ensembl gene ID from the hugo gene symbol 
  ensgID <- hgnc_from_ensembl %>% 
    filter(hgnc_symbol == hgnc) %>% 
    pull(ensembl_gene_id)
  
  #retrieve the ensg transcripts names
  enst <- gte_list %>% 
    pluck(ensgID) %>% 
    names()
  
  # list of tissues/cancers (categories) to which the samples belong
  list_of_categories <- unique(pheno_nh$TCGA_GTEX_main_category) 
  
  # filter retaining the transcripts in enst and their expression level in the different samples
  enst_exp_lev <- enst_expr %>% 
    filter(enst_expr$rowname %in% enst) 
  enst_exp_lev <- enst_exp_lev %>% 
    pivot_longer(., cols = colnames(enst_exp_lev)[-1], 
                 names_to = "sample", values_to = "expression_level")
  
  enst_exp_category = full_join(enst_exp_lev, pheno_nh, by = "sample") %>% 
    dplyr::select(-(dataset)) # the result is a tibble with the transcript on the rows, while on the columns 
  # there is the expression level of each transcript in each category/sample
  
  colnames(enst_exp_category)[c(1,4)] <- c("enst_id", "category")
  
  lt <- length(enst)
  
  palette <- wes_palette("FantasticFox1", lt, "continuous")
  
  plot <- ggplot(enst_exp_category, 
                 mapping = aes(x = category, y = expression_level, fill = enst_id)) +
    geom_boxplot(alpha = 0.8, outlier.shape = NA)  +
    scale_fill_manual(values = palette) +
    ylim(0, 100) +
    theme_light() +
    xlab(" ") +
    ylab("expression level") +
    theme(axis.text.x = element_text(angle = 60, hjust = 1, size = 18),
          axis.title = element_text(size = 19),
          plot.title = element_text(size = 22),
          legend.text = element_text(size = 18), 
          legend.title = element_text(size = 20)) +
    ggtitle(label = paste("Target isoforms expression ", hgnc))
  
  ggsave(filename = paste(hgnc, "_", ensgID, "_plot.pdf", sep = ""), plot = plot, device = "pdf", 
           path = "cartcontent/results/plots/isoform_expression/", 
         width = 100, height = 20, units = "cm", limitsize = F)

    return(plot)
}
# -------------------------------------------------------------------------------------------------

# PLOT OF PROTEIN PROPERTIES

plot_function <- function(genename) {
  
  # import and modify TOPCONS results
  
  topcons_result <- read.table(paste("cartcontent/results/Topcons/", genename, "/seq_0/Topcons/topcons.top", 
                                     sep = ""), 
                               sep = "")
  
  topcons_result <- strsplit(as.character(topcons_result), "")
  topcons_result <- as.data.frame(topcons_result) 
  length_tpc <- length(topcons_result[[1]])
  topcons_result <- cbind(as.integer(rownames(topcons_result)), topcons_result)
  
  colnames(topcons_result) <- c("position", "domain") 
  
  # retrieving the residue positions corresponding to ectodomain, endodomain and TM, 
  # as well as starting and ending positions of each domain
  
  ectodomain <- topcons_result[topcons_result$domain == "o", "position"]
  endodomain <- topcons_result[topcons_result$domain == "i", "position"]
  tm <- topcons_result[topcons_result$domain == "M", "position"]
  
  start_ecto <- ectodomain[c(TRUE,diff(ectodomain)!=1)]
  start_endo <- endodomain[c(TRUE, diff(endodomain) !=1)]
  start_tm <- tm[c(TRUE, diff(tm) !=1)]
  
  end_ecto <- ectodomain[c(diff(ectodomain) != 1, TRUE)]
  end_endo <- endodomain[c(diff(endodomain) !=1, TRUE)]
  end_tm <- tm[c(diff(tm) !=1, TRUE)]
  
  # signal peptide from signalP 
  
  signal_pep <- read.table(paste("cartcontent/results/SignalP/", genename, ".txt", sep = ""),
                           header = T, row.names = NULL, 
                           col.names = c("position", "aa", "SP", "CS", "other", "other2"), sep = "")[1:4]
  
  # retrieving the residue positions corresponding to signal peptide, 
  # as well as its (starting and) ending position 
  
  signal_pep <- signal_pep[signal_pep$SP == "S", "position"]
  
  start_sigp <- signal_pep[c(TRUE, diff(signal_pep) != 1)]
  end_sigp <- signal_pep[c(diff(signal_pep) != 1, TRUE)]  
  
  # epitopes with BepiPred
  
  epitopes <- read.csv(paste("cartcontent/results/BepiPred/", genename, ".csv", sep = ""))
  
  epitopes <- as.tibble(epitopes) %>% 
    filter(EpitopeProbability > 0.5)  # in BepiPred the column EpitopeProbability describes 
  # the probability that the residue is part of a B cell epitope. 
  # If prob > 0,5 the residue is considered to be part of the epitope. 
  
  epitopes_pos <- epitopes$Position
  
  # retrieving starting and ending positions of epitopes
  
  start_epitopes <- epitopes_pos[c(TRUE, diff(epitopes_pos) != 1)]
  end_epitopes <- epitopes_pos[c(diff(epitopes_pos) != 1, TRUE)]
  
  # Phosphorylated residues with NetPhosPan
  
  phos <- read.table(paste("cartcontent/results/NetPhosPan/", genename, ".xls", sep = ""), 
                     sep = "\t", header = T)
  
  phos_pos <- phos$Pos
  
  # retrieving starting and ending positions of phosphorylated regions
  
  if (is.null(nrow(phos_pos)) == T) {
    start_phosp <- as.integer(NA)
    end_phosp <- as.integer(NA)
  } else {
    start_phosp <- phos_pos[c(TRUE, diff(phos_pos) != 1)]
    end_phosp <- phos_pos[c(diff(phos_pos) != 1, TRUE)] + 1  # Without the +1, the PTMs involving only one residue are not shown in the plot.
    
  }
  
  # glycosilated sites with NetOglyc
  
  glyc <- read.table(paste("cartcontent/results/NetOGlyc/", genename, ".txt", sep = ""), 
                     fill = T, header = T)[1:6]
  
  glyc <- as.tibble(glyc) %>% filter(score > 0.5) # A residue is considered glycosylated if score is > 0.5. 
  
  if (nrow(glyc) != 0) {
    start_glyc <- glyc$start
    end_glyc <- glyc$end + 1 # Without the +1, the PTMs involving only one residue are not shown in the plot.
  } else { 
    start_glyc <- as.integer(NA)
    end_glyc <- as.integer(NA)
  }
  
  
  # preparing the dataframes in order to plot with geom_rect (ggplot2)
  
  # "start" marks every starting point of a region (ecto, endo, signalp, etc)
  # "end" marks the end
  # "bin" marks the row on the plot (ecto==1, endo==2, signalp==3, epitope==4, etc)
  ecto <- data.frame(start= start_ecto, end = end_ecto, bin = rep(7, length(start_ecto)))
  trm <- data.frame(start = start_tm, end = end_tm, bin = rep(6, length(start_tm)))
  endo <- data.frame(start = start_endo, end = end_endo, bin = rep(5, length(start_endo)))
  sigp <- data.frame(start = start_sigp, end = end_sigp, bin = rep(4, length(start_sigp)))
  epi <- data.frame(start = start_epitopes, end = end_epitopes, bin = rep(3, length(start_epitopes)))
  phosp <- data.frame(start = start_phosp, end = end_phosp, bin = rep(2, length(start_phosp)))
  glyco <- data.frame(start = start_glyc, end = end_glyc, bin = rep(1, length(start_glyc)))
  
  palette <- c("#8EDCE6", "#E0A900","#1C8DD9", "#FF8C42", "#025C40", "#C14953", "#576490") 
  
  p <- ggplot(mapping = aes(label = "mytext")) + 
    geom_rect(data = ecto, aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, 
                               fill = "Ectodomain"), alpha = 0.8) +
    geom_text(x = -(length_tpc/5), y = 7.5, size = 5, mapping = aes(label = "Ectodomain")) +
    
    geom_rect(data = trm, aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, 
                              fill ="TM"), alpha = 0.8) +
    geom_text(x = -(length_tpc/5), y = 6.5, size = 5, mapping = aes(label = "TM")) +
    
    geom_rect(data = endo, aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, 
                               fill ="Endodomain"), alpha = 0.8) +
    geom_text(x = -(length_tpc/5), y = 5.5, size = 5, mapping = aes(label = "Endodomain")) +
    
    geom_rect(data = sigp, aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, 
                               fill ="Signal peptide"), alpha = 0.8) +
    geom_text(x = -(length_tpc/5), y = 4.5, size = 5, mapping = aes(label = "Signal Peptide")) +
    
    geom_rect(data = epi, aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, 
                              fill ="Potential Epitopes"), alpha = 0.8) +
    geom_text(x = -(length_tpc/5), y = 3.5, size = 5, mapping = aes(label = "Potential Epitopes")) +
    
    geom_rect(data = phosp, aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, 
                                fill ="Phosphorylation sites"), alpha = 0.8) +
    geom_text(x = -(length_tpc/5), y = 2.5, size = 5, mapping = aes(label = "Phosphorylation Sites")) +
    
    geom_rect(data = glyco, aes(xmin = start, xmax = end, ymin = bin + 0.1, ymax = bin + 0.9, 
                                fill ="Glycosylation sites"), alpha = 0.8) +
    geom_text(x = -(length_tpc/5), y = 1.5, size = 5, mapping = aes(label = "Glycosylation Sites")) +
    
    ggtitle(genename) +
    xlab("Positions") +
    theme_light() +
    theme(plot.title = element_text(hjust = 0.5), 
          legend.position = "NULL", 
          plot.margin = unit(c(1,1,1,7), "cm")) +
    theme(plot.title = element_text(size = 20)) +
    coord_cartesian(clip = "off") +
    theme(text = element_text(size = 14),
          axis.text.x = element_text(size = 12),
          axis.text.y = element_blank(), 
          axis.ticks = element_blank()) +
    scale_fill_manual(values = palette) 
  
  ggsave(filename = paste(genename, "_plot.pdf", sep = ""), plot = p, device = "pdf", 
         path = "cartcontent/results/plots/protein_properties/", width = 30, height = 15, units = "cm")
  
  return(p)
  
}








