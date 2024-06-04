# Biomart script 
rm(list = ls())
library(tidyverse)
library(biomaRt)
load(file = "cartcontent/data/expr_sub.Rdata")

# conversion of the ensg id into gene symbols. In the website there will be gene symbols, not ensg id.
# if a timeout error pops up, try to clean the environment and run again and/or edit the timeout. 

mart1 <- useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl")

hgnc_from_ensembl <- getBM(attributes = c("ensembl_gene_id","hgnc_symbol"), 
                           filters = "ensembl_gene_id", 
                           mart = mart1, 
                           values = rownames(ensg_expr))

hgnc_from_ensembl[34,2] <- "CEA" # the hgcn for the ensgID ENSG00000267881 is not in biomart, 
# so I am adding it manually

saveRDS(hgnc_from_ensembl, "cartcontent/results/001_hgnc_from_ensembl_biomart.rds")







