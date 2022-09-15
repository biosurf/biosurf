# multiple sequencing alignment script
# take isoforms from UniProt and align them. Needed for the "protein properties" plot.
rm(list = ls())
library(tidyverse)
library(ggplot2)
library(msa)

msa_function <- function(hgnc) {
  sequences <- readAAStringSet(format = "fasta", filepath = paste("cartcontent/data/FASTA_sequences_uniprot/canonical_and_isoforms/", hgnc, ".txt", sep = ""))
  if(length(sequences) != 1) {
    aligned_sequences <- msa(sequences)
    # print(aligned_sequences, show = "complete")
    # save the msa object into a fasta file
    writeXStringSet(unmasked(aligned_sequences), filepath = paste("cartcontent/results/aligned_sequences/", hgnc, "_msa", sep = ""))
  } else if(length(sequences) == 1) {print(i)}
}

target_list <- c("ALPP", "AXL", "CD19", "CD22", "CD33", "CD38", "CD70", "CD276", "CEACAM5", "CLDN18", 
                 "EGFR", "EPCAM", "ERBB2", "FOLH1", "GPC3", "IL3RA", "MET", "MS4A1", "MSLN", "MUC1", "PSCA", "RAET1E", 
                 "ROR2", "TNFRSF10B", "TNFRSF17", "ULBP1", "ULBP2", "ULBP3") 

for(i in 1:length(target_list)) {
  name <- target_list[i]
  msa_function(hgnc = name)
}


