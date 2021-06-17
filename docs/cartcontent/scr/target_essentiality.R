# TARGET ESSENTIALITY
# goal: to create a boxplot for each gene, describing the essentiality of the gene
# across different cancers. 
# The table containing the essentiality score is from depmap (file description: 
# _Post-CERES_ Combined Achilles and Sanger SCORE data using Harmonia 
# (the batch correction pipeline described here: https://www.biorxiv.org/content/10.1101/2020.05.22.110247v3) 
# Columns: genes in the format "HUGO (Entrez)" - Rows: cell lines (Broad IDs)). 
# The cell lines represent different cancers. 

library(depmap)
library(tidyverse)

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

rm(depmap_crispr)

crispr_targ_ess <- crispr_targ_ess %>% 
  pivot_longer(cols = -c(depmap_id, cell_line), names_to = "genes", values_to = "essentiality_score")

saveRDS(crispr_targ_ess, file = "cartcontent/scr/crispr_target_essentiality.rds")
crispr_targ_ess <- readRDS(file = "cartcontent/scr/crispr_target_essentiality.rds")

gene <- crispr_targ_ess %>% 
  filter(str_detect(genes, "^ALPP.."))


gene <- gene %>% 
  separate(col = "cell_line", into = c(NA, "cancer"), extra = "merge") %>% 
  separate(col = "genes", into = c("hgcn", "entrez"), sep = "\\.\\.") %>% 
  mutate(entrez = str_remove(entrez, pattern = "\\."))


View(head(crispr_targ_ess))
View(gene)

gene %>% ggplot(mapping = aes(x = cancer, y = essentiality_score)) +
  geom_boxplot() 
  

