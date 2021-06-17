# TARGET ESSENTIALITY
# goal: to create for each gene a table cpntaining the genename, the essentiality scores and the cancer for 
# which the scores are calculated. 
# Each of these tables will be used then in creating the boxplot for target essentiality. 
# The table containing the essentiality score is from depmap (file description: 
# _Post-CERES_ Combined Achilles and Sanger SCORE data using Harmonia 
# (the batch correction pipeline described here: https://www.biorxiv.org/content/10.1101/2020.05.22.110247v3) 
# Columns: genes in the format "HUGO (Entrez)" - Rows: cell lines (Broad IDs)). 
# The cell lines represent different cancers. 

library(depmap)
library(tidyverse)
library(wesanderson)

# import the file with the target names 
targets <- read.table("cartcontent/data/targets_tcga.txt", header = F, sep = "") 

# !!!!!! IMPORTANT !!!!!! the targets_tcga.txt needs to be updated including TNFRSF17 gene
# after I receive the isoforms expression data

# import the table containing the target essentiality data
crispr_targ_ess <- read.csv("cartcontent/data/CRISPR_gene_effect.csv") 
colnames(crispr_targ_ess)[1] <- "depmap_id"

# import the depmap crispr dataset, since it contains the common CCLE name of 
# each cancer cell line, coupled with the depmap ID. 
depmap_crispr <- depmap_crispr()

depmap_id <- depmap_crispr %>% 
  dplyr::select("depmap_id", "cell_line")  %>% 
  unique()

crispr_targ_ess <- full_join(crispr_targ_ess, depmap_id, by = "depmap_id")

# looking into the crispr_targ_ess dataset, it appears that the cell_line associated to 
# the depmap_id ACH-002315 is NA. 
# looking at the depmap website (announcements) it seems that they have removed said cell line
# since it is a duplicate entry (sentence: Removing Cell Lines from all Omics datasets --> We are removing 
# ACH-001189, ACH-002303, ACH-002315, ACH-002341 from the all omics datasets since they are duplicate entries.)
# in the following chunck of code I am verifying that all the NAs in the table are associated to 
# said cell_line. 

crispr_targ_ess %>% filter(depmap_id == "ACH-002315") %>% 
  dplyr::select(cell_line) %>% 
  is.na() %>% 
  summary()

# since the NAs are associated to ACH-002315 cell line, I will remove the rows containing NAs. 

crispr_targ_ess <- crispr_targ_ess %>% na.omit()

crispr_targ_ess <- crispr_targ_ess %>% 
  pivot_longer(cols = -c(depmap_id, cell_line), names_to = "genes", values_to = "essentiality_score")

#saveRDS(crispr_targ_ess, file = "cartcontent/scr/crispr_target_essentiality.rds")
#crispr_targ_ess <- readRDS(file = "cartcontent/scr/crispr_target_essentiality.rds")

saving_essentiality_fun <- function(genename) {
  # filter for the rows containing data of the specific gene. In the table, the column "genes" is in the 
  # following format: HGNC..ENTREZID. (e.g. ALPP..250.) 
  gene <- crispr_targ_ess %>% 
    filter(str_detect(genes, paste("^", genename, "..", sep = "")))
  # creating two colomns out of the "genes" column (from a HGNC..ENTREZID. to a HGCN column and a ENTREZID column)
  # creating a "cancer" column out of the "cell_line" column (from XXXXX_CANCERTYPE to CANCERTYPE)
  gene <- gene %>% 
    separate(col = "cell_line", into = c(NA, "cancer"), extra = "merge") %>% 
    separate(col = "genes", into = c("hgcn", "entrez"), sep = "\\.\\.") %>% 
    mutate(entrez = str_remove(entrez, pattern = "\\."))

  saveRDS(gene, file = paste("cartcontent/scr/", 
                                        genename, 
                                        "_crispr_target_essentiality.rds", 
                                        sep = ""))
}

for (i in 1:length(targets$V1)) {
  gene <- targets$V1[i]
  saving_essentiality_fun(genename = gene)
  print(i)
}


