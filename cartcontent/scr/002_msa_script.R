# multiple sequencing alignment script
# take isoforms from UniProt and align them. Needed for the "protein properties" plot.
rm(list = ls())

library(tidyverse)
library(ggplot2)
library(readxl)
library(msa)

load(file = "cartcontent/data/expr_sub.Rdata")
load(file = "cartcontent/data/gte.Rdata")
pheno <- read_rds("cartcontent/data/pheno.rds")

enst_expr <- enst_expr %>%
  rownames_to_column()
enst_expr <- as_tibble(enst_expr)

# # retrieve the haematological cancer categories since we decided to exclude them from the analyses
# haematological_cancers <- c("blood", "diffuse large b-cell lymphoma", "acute myeloid leukemia" )
# 
# pheno_nh <- pheno[!(pheno$TCGA_GTEX_main_category %in% haematological_cancers), ] # removal of the hematological cancers

msa_function <- function(hgnc, pheno) {
  
  # before aligning the sequences I need to discard the isoforms that I don't want, 
  # otherwise the protein properties picture looks weird. In the following I am deleting from
  # the fasta the isoforms that are not protein coding and that do not have expression data.
  
  hgnc_from_ensembl <- readRDS(file = "cartcontent/results/001_hgnc_from_ensembl_biomart.rds")
  
  #retrieve the ensembl gene ID from the hugo gene symbol 
  ensgID <- hgnc_from_ensembl %>% 
    filter(hgnc_symbol == hgnc) %>% 
    pull(ensembl_gene_id)
  
  #retrieve the ensg transcripts names
  enst <- gte_list %>% 
    pluck(ensgID) %>% 
    names()
  
  # list of tissues/cancers (categories) to which the samples belong
  list_of_categories <- unique(pheno$TCGA_GTEX_main_category) 
  
  # import transcript data from ensembl website --> I want to keep only the protein coding transcripts
  
  ensembl_table <- read_xlsx(paste("cartcontent/data/isoforms/transcripts_", hgnc, ".xlsx", sep = ""), 
                             col_names = TRUE, skip = 1) # skip = 1 is necessary to have colnames
  
  # eliminate the version number from transcripts 
  ensembl_table <- ensembl_table %>% separate(., col = `Transcript ID`, into = c("transcript", NA), sep = "\\.")
  ensembl_table <- ensembl_table %>% filter(grepl("Protein coding",Biotype))
  ensembl_table <- ensembl_table %>% dplyr::select(transcript, `UniProt Match`)
  # the following line is used in case one transcript has multiple values in the "UniProt Match" column. It will keep the first one, which
  # is the one matching with the UniProt name in the aligned sequences file (at least for the target tested up until now).If this is not done,
  # the transcript with 2 UniProt names will be discarded downstream.
  ensembl_table <- ensembl_table %>% separate(., col = `UniProt Match`, into = c("UniProt Match", NA), sep = " ")
  
  # convert the vector enst into a 1 column tibble
  enst <- as_tibble_col(enst, column_name = "transcript")
  
  # join the two tables keeping only the transcripts that are in common (--> protein coding in ensembl
  # and in the gte_list object)
  
  ensembl_uniprot_table <- semi_join(ensembl_table, enst, by = "transcript") 
  
  # keeping the isoforms that are protein coding and that have expression data.
  
  match <- ensembl_uniprot_table$`UniProt Match` %>% as.character()
  match <- paste(match,collapse = "|")
  
  sequences <- readAAStringSet(format = "fasta", 
                               filepath = paste("cartcontent/data/FASTA_sequences_uniprot/canonical_and_isoforms/", 
                                                hgnc, ".txt", sep = ""))
  protein_coding_with_expr <- names(sequences) %>% as_tibble()
  
  protein_coding_with_expr <- protein_coding_with_expr %>% filter(grepl(match, value))
  
  sequences <- sequences[names(sequences) %in% protein_coding_with_expr$value]
  
  if(length(sequences) != 1) {
    aligned_sequences <- msa(sequences)
    # print(aligned_sequences, show = "complete")
    # save the msa object into a fasta file
    writeXStringSet(unmasked(aligned_sequences), filepath = paste("cartcontent/results/aligned_sequences/", 
                                                                  hgnc, "_msa.txt", sep = ""))
  } else if(length(sequences) == 1) {print(i)}
}

target_list <- c("ALPP", "AXL", "CD19", "CD22", "CD33", "CD38", "CD7", "CD70", "CD276", "CEACAM5", "CLDN18", 
                 "EGFR", "EPCAM", "ERBB2", "FOLH1", "GPC3", "IL3RA", "MET", "MS4A1", "MSLN", "MUC1", "PSCA", "RAET1E", 
                 "ROR2", "TNFRSF10B", "TNFRSF17", "ULBP1", "ULBP2", "ULBP3") 

for(i in 1:length(target_list)) {
  name <- target_list[i]
  msa_function(hgnc = name, pheno = pheno)
}

# note that msa does not work if the target only has one isoform (such as ALPP, ULBP1, ULBP2, ULBP3), so in this case, the _msa file remains the input FASTA. 