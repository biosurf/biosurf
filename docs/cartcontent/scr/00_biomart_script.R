# Biomart script 
library(tidyverse)
library(tibble)
library(janitor)
library(wesanderson)
library(biomaRt)
library(patchwork)
library(depmap)
library(Ipaper)

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

# hgnc_from_ensembl[34,2] <- "CEA" # the hgcn for the ensgID ENSG00000267881 is not in biomart, 
# so I am adding it manually
#hgnc <- "MUC1"


saveRDS(hgnc_from_ensembl, "cartcontent/results/00_hgnc_from_ensembl_biomart.rds")







