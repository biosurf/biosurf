# data wrangling preliminary to target-specific analyses.

library(tidyverse)

# import files: 
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


load(file = "cartcontent/data/expr_sub.Rdata")
# load(file = "cartcontent/data/gte.Rdata")
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

saveRDS(object = enst_expr, "cartcontent/results/01_wrangled_data/01_enst_expr.rds")
saveRDS(object = ensg_expr, "cartcontent/results/01_wrangled_data/01_ensg_expr.rds")
saveRDS(object = pheno_nh, "cartcontent/results/01_wrangled_data/01_pheno_no_haematological_cancers.rds")

