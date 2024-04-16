# HER2 thesis plot isoform expression

library(tidyverse)
library(tibble)
library(janitor)
library(wesanderson)
library(biomaRt)
library(patchwork)
library(depmap)
library(Ipaper)
library(tidysq) #read fasta file
library(readxl)

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


  hgnc_from_ensembl <- readRDS(file = "cartcontent/results/00_hgnc_from_ensembl_biomart.rds")
  
  #retrieve the ensembl gene ID from the hugo gene symbol 
  ensgID <- hgnc_from_ensembl %>% 
    filter(hgnc_symbol == "ERBB2") %>% 
    pull(ensembl_gene_id)
  
  #retrieve the ensg transcripts names
  enst <- gte_list %>% 
    pluck(ensgID) %>% 
    names()
  
  # list of tissues/cancers (categories) to which the samples belong
  list_of_categories <- unique(pheno_nh$TCGA_GTEX_main_category) 

  # import transcript data from ensembl website --> I want to retain only the protein coding transcripts
  
  ensembl_table <- read_xlsx("cartcontent/data/isoforms/transcripts_ERBB2.xlsx", 
                             col_names = TRUE, skip = 1) # skip = 1 is necessary to have colnames
  
  # eliminate the version number from transcripts 
  ensembl_table <- ensembl_table %>% separate(., col = `Transcript ID`, into = c("transcript", NA), sep = "\\.")
  ensembl_table <- ensembl_table %>% filter(grepl("Protein coding",Biotype))
  ensembl_table <- ensembl_table %>% dplyr::select(transcript, `UniProt Match`)
  
  # convert the vector enst into a 1 column tibble
  enst <- as_tibble_col(enst, column_name = "transcript")
  
  # join the two tables retaining only the transcripts that are in common (--> protein coding in ensembl
  # and in the gte_list object)
  
  ensembl_uniprot_table <- semi_join(ensembl_table, enst, by = "transcript") 
  colnames(ensembl_uniprot_table)[2] <- "name"
  
  # create a new enst object, that only contains the protein coding isoforms in gte_list
  enst <- ensembl_uniprot_table$transcript
  
  # filter retaining the transcripts in enst and their expression level in the different samples
  enst_exp_lev <- enst_expr %>% 
    filter(enst_expr$rowname %in% enst) 
  enst_exp_lev <- enst_exp_lev %>% 
    pivot_longer(., cols = colnames(enst_exp_lev)[-1], 
                 names_to = "sample", values_to = "expression_level")
  
  enst_exp_category_tcga_full <- full_join(enst_exp_lev, pheno_nh, by = "sample") %>% 
    filter(dataset == "tcga") %>% 
    dplyr::select(-(dataset)) # the result is a tibble with the transcript on the rows, while on the columns 
  # there is the expression level of each transcript in each category/sample
  
  TCGA_keep <- c("lung adenocarcinoma" , "ovarian serous cystadenocarcinoma", 
                 "lung squamous cell carcinoma", "rectum adenocarcinoma", "colon adenocarcinoma", 
                 "breast invasive carcinoma", "pancreatic adenocarcinoma"
                 )
  
  enst_exp_category_tcga <- enst_exp_category_tcga_full %>% 
    filter(TCGA_GTEX_main_category %in% TCGA_keep)
  
  
  
  enst_exp_category_gtex_full <- full_join(enst_exp_lev, pheno_nh, by = "sample") %>% 
    filter(dataset == "gtex") %>% 
    dplyr::select(-(dataset)) # the result is a tibble with the transcript on the rows, while on the columns 
  # there is the expression level of each transcript in each category/sample
  
  GTEX_keep <- c("colon", "heart", "breast", "muscle", "lung", "ovary", "kidney")
  
  
  enst_exp_category_gtex <- enst_exp_category_gtex_full %>% 
    filter(TCGA_GTEX_main_category %in% GTEX_keep)
  
  colnames(enst_exp_category_tcga)[c(1,4)] <- c("enst_id", "category")
  colnames(enst_exp_category_gtex)[c(1,4)] <- c("enst_id", "category")
  
  enst_exp_category_tcga <- enst_exp_category_tcga %>% 
    mutate(expression_level = log2(expression_level + 1))
  enst_exp_category_gtex <- enst_exp_category_gtex %>% 
    mutate(expression_level = log2(expression_level + 1))
  
  lt <- length(enst)
  
  palette <- wes_palette("FantasticFox1", lt, "continuous")
  
  # plot_tcga <- ggplot(enst_exp_category_tcga,
  #                     mapping = aes(x = category, y = expression_level, fill = enst_id)) +
  #   geom_boxplot(alpha = 0.9, outlier.shape = NA, width = 0.9) +
  #   scale_fill_manual(values = palette) +
  #   ylim(0, max(enst_exp_category_tcga$expression_level)) +
  #   theme_light() +
  #   xlab(" ") +
  #   ylab("Log2(TPM)") +
  #   theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 40),
  #         axis.text.y = element_text(size = 35),
  #         axis.title = element_text(size = 35),
  #         plot.title = element_text(size = 50),
  #         legend.text = element_text(size = 30),
  #         legend.title = element_text(size = 35),
  #         plot.margin = unit(c(1,1,1,5), "cm"),
  #         legend.position = "bottom") +
  #   ggtitle(label = paste("Target isoforms expression for TCGA cancers"))
  
  enst_canonical_only_tcga <- enst_exp_category_tcga %>% filter(enst_id == "ENST00000269571")
  
  plot_tcga <- ggplot(enst_canonical_only_tcga,
                      mapping = aes(x = category, y = expression_level), fill = "#84BB78") +
    geom_boxplot(alpha = 0.9, outlier.shape = NA, width = 0.4, fill = "#84BB78") +
    #scale_fill_manual(values = palette[5]) +
    ylim(0, 8) +
    theme_light() +
    xlab(" ") +
    ylab("Log2(TPM)") +
    theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 45),
          axis.text.y = element_text(size = 40),
          axis.title = element_text(size = 40),
          plot.title = element_text(size = 60),
          legend.text = element_text(size = 48),
          legend.title = element_text(size = 60),
          plot.margin = unit(c(1,1,1,10), "cm"),
          legend.position = "bottom") +
    ggtitle(label = paste("HER2 expression for TCGA cancers"))
  
  enst_canonical_only_gtex <- enst_exp_category_gtex %>% filter(enst_id == "ENST00000269571")
  
  plot_gtex <- ggplot(enst_canonical_only_gtex,
                      mapping = aes(x = category, y = expression_level)) +
    geom_boxplot(alpha = 0.9, outlier.shape = NA, width = 0.4, fill = "#84BB78")  +
    #scale_fill_manual(values = palette[5]) +
    ylim(0, 8) +
    theme_light() +
    xlab(" ") +
    ylab("Log2(TPM)") +
    theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 45),
          axis.text.y = element_text(size = 40),
          axis.title = element_text(size = 40),
          plot.title = element_text(size = 60),
          # legend.text = element_text(size = 30),
          # legend.title = element_text(size = 35),
          plot.margin = unit(c(1,6,1,4), "cm"), 
          legend.position = "none") +
    ggtitle(label = paste("HER2 expression for GTEX  normal tissues"))
  
  plot <- plot_tcga + plot_gtex
  
  ggsave(filename = "HER2_thesis_expression_plot_canonical only.pdf", plot = plot, device = "pdf",
         path = "cartcontent/results/plots/isoform_expression/",
         width = 120, height = 55, units = "cm", limitsize = F)
