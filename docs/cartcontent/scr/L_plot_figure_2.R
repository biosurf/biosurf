library(ggplot2)
library(reshape2)
library(parallel)
library(patchwork)
library(IRanges)
library(stringr)
library(ggridges)

source("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/GeomSplitViolin.R")
source("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/plotRanges_w_dist.R")
source("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/outersect.R")

load("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/trial_target_assessments/expr_sub_giorgia.Rdata")
load("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/gte.Rdata")
pheno <- readRDS("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/pheno.rds")

gene <- "ENSG00000141736"
gene_name <- "ERBB2"
cancer <- c("sarcoma", "glioblastoma multiforme", "breast invasive carcinoma") # list: unique(pheno$TCGA_GTEX_main_category)

# gene <- "ENSG00000147257"
# gene_name <- "GPC3"
# cancer <- c("liver hepatocellular carcinoma") # list: unique(pheno$TCGA_GTEX_main_category)

# gene <- "ENSG00000102854"
# gene_name <- "MSLN"
# cancer <- c("liver hepatocellular carcinoma") # list: unique(pheno$TCGA_GTEX_main_category)

# gene <- "ENSG00000185499"
# gene_name <- "MUC1"
# cancer <- c("breast invasive carcinoma", "liver hepatocellular carcinoma", "pancreatic adenocarcinoma") # list: unique(pheno$TCGA_GTEX_main_category)

# gene <- "ENSG00000105388"
# gene_name <- "CEACAM5"
# cancer <- c("colon adenocarcinoma") # list: unique(pheno$TCGA_GTEX_main_category)


enst2uniprot <- read.table(paste0("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/figure2_data/", gene_name, "_enst2uniprot.txt"), header=TRUE)
table(enst2uniprot$enst %in% names(gte_list[[gene]]))

# Plot topology
tr <- read.table(paste0("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/figure2_data/", gene_name, "_ranges.txt"), header=TRUE, sep="\t")
# tr <- read.table("/Users/lro 1 2/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/ADGRV1_prot.txt", header=TRUE, sep="\t")
tr$Topology <- factor(tr$Topology, levels=c("S", "o", "M", "i", "-"), labels=c('Signal peptide','Outside','Trans membrane','Inside','Alignment gap'))
t <- ggplot(tr, aes(xmin=start, xmax=end,  ymin = bin + 0.1, ymax = bin + 0.9, fill=Topology)) +
  scale_y_continuous(limits = c(0.9, max(tr$bin)+1.1), expand = c(0, 0)) +
  geom_rect() +
  ggtitle("Protein topologies") +
  scale_fill_manual(values=c("#904E55", "#FFA62B", "#489FB5", "#16697A", "#EDE7E3")) +
  xlab("Amino acid position in multiple sequence alignment") +
  theme_bw() +
  labs(fill = "Protein topology") +
  theme(axis.ticks = element_blank(), axis.text.y = element_blank())

# Subcellular location
loc <- read.table(paste0("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/figure2_data/", gene_name, "_loc_table.txt"), header=TRUE, sep="\t")
loc$uniprot <- factor(loc$uniprot, levels = loc$uniprot)
loc_long <- melt(loc)
loc_long$value <- round(loc_long$value, digits=2)
colnames(loc_long) <- c("Isoform", "Type", "Subcellular location", "Probability")
s <- ggplot(loc_long, aes(x=`Subcellular location`, y=Isoform, fill=Probability)) +
  geom_tile(color="black") +
  scale_fill_gradient(low = "white", high = "#EE6352") +
  geom_text(aes(label = Probability), color = "black", size=2.5) +
  coord_fixed() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

# loc <- read.table(paste0("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/figure2_data/", gene_name, "_loc.txt"), header=TRUE, sep="\t")
# s <- ggplot(data.frame(x=1, y=0.5:(length(loc$isoform))+1), aes(x,y,label=loc$location)) +
#   geom_text() +
#   scale_y_continuous(breaks = 1:(length(loc$isoform))+0.5, limits = c(0.9, nrow(loc)+1.1), expand = c(0, 0), labels= loc$isoform) + ## c(rownames(z), "Transcript union")
#   ylab("Isoform (Uniprot ID)") +
#   ggtitle("Subcellular location") +
#   theme_bw() +
#   theme(axis.ticks = element_blank(), panel.grid = element_blank(), axis.title.x = element_blank(), axis.text.x = element_blank())

# Plot densities
v <- list()
for(c in cancer) {
  cancer_samples <- pheno[pheno$TCGA_GTEX_main_category==c,]$sample
  normal_sample <- pheno[grep("GTEX", pheno$sample),]$sample
  enst_expr_sub <- enst_expr[rownames(enst_expr) %in% enst2uniprot$enst,colnames(enst_expr) %in% c(as.character(cancer_samples), as.character(normal_sample))]
  enst2uniprot <- enst2uniprot[match(loc$uniprot, enst2uniprot$uniprot),]
  enst_expr_sub <- enst_expr_sub[match(enst2uniprot$enst, rownames(enst_expr_sub)),]
  
  # calculate average transcript frequency
  enst_expr_sub_cancer <- enst_expr_sub[,grepl("TCGA", colnames(enst_expr_sub))]
  enst_expr_sub_cancer_freq <- apply(enst_expr_sub_cancer, 2, function(x) x/sum(x))
  av_trans_freq <- round(rowMeans(enst_expr_sub_cancer_freq)*100,2)
    
  df <- melt(t(enst_expr_sub))
  tissue <- rep("", nrow(df))
  tissue[grepl("GTEX", df$Var1)] <- "Normal"
  tissue[!tissue=="Normal"] <- "Cancer"
  df$tissue <- factor(tissue, levels=c("Cancer", "Normal"))
  colnames(df) <- c("Sample", "Transcript", "Expression", "Tissue")
  df$Expression <- log2(df$Expression+0.001)
  
  v[[c]] <- ggplot(df, aes(x=Expression, y=Transcript, fill=Tissue, color=Tissue)) +
    geom_density_ridges(alpha = 0.5) +
    ggtitle(str_to_sentence(c)) +
    scale_fill_manual(values=c("#E26D5A", "#156064")) +
    ylab("") +
    xlab("log2(tpm+0.001)") +
    theme_bw() +
    labs(fill = "Tissue") +
    scale_y_discrete(labels = paste0("(", av_trans_freq, "%)"), expand = expansion(mult = c(0, 0.08))) +
    theme(axis.title.y=element_blank()) +
  
  if(c==cancer[length(cancer)]) {
    v[[c]] <- v[[c]] + theme(axis.ticks = element_blank())
  }
  if(c!=cancer[length(cancer)]) {
    v[[c]] <- v[[c]] + theme(axis.ticks = element_blank(), legend.position = "none")
  }
}

# # Plot violins
# v <- list()
# for(c in cancer) {
#   cancer_samples <- pheno[pheno$TCGA_GTEX_main_category==c,]$sample
#   normal_sample <- pheno[grep("GTEX", pheno$sample),]$sample
#   enst_expr_sub <- enst_expr[rownames(enst_expr) %in% enst2uniprot$enst,colnames(enst_expr) %in% c(as.character(cancer_samples), as.character(normal_sample))]
#   enst2uniprot <- enst2uniprot[match(loc$isoform, enst2uniprot$uniprot),]
#   enst_expr_sub <- enst_expr_sub[match(enst2uniprot$enst, rownames(enst_expr_sub)),]
#   
#   df <- melt(t(enst_expr_sub))
#   tissue <- rep("", nrow(df))
#   tissue[grepl("GTEX", df$Var1)] <- "Normal"
#   tissue[!tissue=="Normal"] <- "Cancer"
#   df$tissue <- factor(tissue, levels=c("Cancer", "Normal"))
#   colnames(df) <- c("Sample", "Transcript", "Expression", "Tissue")
#   df$Expression <- log2(df$Expression+0.001)
#   v[[c]] <- ggplot(df, aes(Transcript, Expression, fill = Tissue)) + 
#     geom_split_violin(color=NA) +
#     ggtitle(str_to_sentence(c)) +
#     scale_fill_manual(values=c("#E26D5A", "#156064")) +
#     ylab("log2(tpm+0.001)") +
#     xlab("") +
#     coord_flip() +
#     theme_bw() +
#     labs(fill = "Tissue")
#   if(c==cancer[length(cancer)]) {
#     v[[c]] <- v[[c]] + theme(axis.ticks = element_blank(), axis.text.y = element_blank())
#   }
#   if(c!=cancer[length(cancer)]) {
#     v[[c]] <- v[[c]] + theme(axis.ticks = element_blank(), axis.text.y = element_blank(), legend.position = "none")
#   }
# }
# v <- wrap_plots(v)

# Plot ranges
r <- plotRanges(gene, enst_expr_sub, gte_list)

# Plot together
panelwidth <- 1
if(length(cancer) > 1) {
  panelwidth <- length(cancer)*2
}
p1 <- r+v+plot_layout(widths = c(2.1, 2, 2, 2), nrow=1, ncol=4)
p2 <- s+t+plot_layout(widths = c(3, 12))
p3 <- p1/p2+plot_annotation(tag_levels = 'A')
pdfwidth <- 14
if(length(cancer) > 1) {
  pdfwidth <- 14+length(cancer)*2
}
ggsave(p3, file=paste0("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/figure2/", gene_name, ".pdf"), width=19, height=8)
