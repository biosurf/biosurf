# TARGET ESSENTIALITY
# goal: to create for each gene a table cpntaining the genename, the essentiality scores and the cancer for 
# which the scores are calculated. 
# Each of these tables will be used then in creating the boxplot for target essentiality. 
# The table containing the essentiality score is from depmap (file description: 
# _Post-CERES_ Combined Achilles and Sanger SCORE data using Harmonia 
# (the batch correction pipeline described here: https://www.biorxiv.org/content/10.1101/2020.05.22.110247v3) 
# Columns: genes in the format "HUGO (Entrez)" - Rows: cell lines (Broad IDs)). 
# The cell lines represent different cancers. 

library(depmap) # http://127.0.0.1:29531/library/depmap/doc/depmap.html#32_CRISPR-Cas9_knockout_data
library(tidyverse)
library(wesanderson)
library(ExperimentHub)

# import the file with the target names 
targets <- read.table("cartcontent/data/targets_tcga.txt", header = F, sep = "") 

eh <- ExperimentHub()
query(eh, "depmap")
crispr <- eh[["EH6118"]] # import the most recent crispr dataset, containing the essentiality data. 
# Note that the most recent crispr dataset can be automatically loaded into
# R by using the depmap_crispr() function.

# looking into the crispr dataset, it appears that the cell_line associated to 
# the depmap_id ACH-002315 is NA. 
# looking at the depmap website (announcements) it seems that they have removed said cell line
# since it is a duplicate entry (sentence: Removing Cell Lines from all Omics datasets --> We are removing 
# ACH-001189, ACH-002303, ACH-002315, ACH-002341 from the all omics datasets since they are duplicate entries.)
# in the following chunck of code I am verifying that all the NAs in the table are associated to 
# said cell_line. 

crispr %>%  is.na() %>% summary()
crispr %>% filter(depmap_id == "ACH-002315") %>% 
  dplyr::select(cell_line) %>% 
  is.na() %>% 
  summary() 
# moreover 
crispr %>% dplyr::filter(is.na(dependency)) # 17453 dependency scores (essentiality scores) are missing

# I am removing the rows containing NAs. 

crispr <- crispr %>% na.omit()

saveRDS(crispr, file = "crispr_target_essentiality.rds")

