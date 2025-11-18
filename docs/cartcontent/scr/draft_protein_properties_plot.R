rm(list = ls())

# protein properties plot 
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

#hgnc <- "ERBB2"
hgnc_from_ensembl <- readRDS(file = "cartcontent/results/00_hgnc_from_ensembl_biomart.rds")


# !!!!!!!!!!!!!!!!!!! READ THE FOLLLOWING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# in the following you'll be importing a table from ensembl website, containing the names of the different isoform for 
# a certain gene (hgnc). CHECK THAT THE NAMES IN THE ENSG TABLE AND THE ONES IN THE FASTA FILES ARE THE SAME (especially for the main isoform, that sometimes has a -1
# in the name and sometimes does not). If you don't check it, and something is wrong, the non matching name are going to be deleted and you might lose data.

plot_function <- function(hgnc) {
  #retrieve the ensembl gene ID from the hugo gene symbol 
  ensgID <- hgnc_from_ensembl %>% 
    filter(hgnc_symbol == hgnc) %>% 
    pull(ensembl_gene_id)
  
  #retrieve the ensg transcripts names
  enst <- gte_list %>% 
    pluck(ensgID) %>% 
    names()
  # the isoform sequences can be downloaded from uniprot (canonical + isoforms) and saved in a txt file. Said
  # file is then used as input in deeptmhmm. 
  # in the analyses we are retaining only the protein coding isoforms. The information can be 
  # found and downloaded from the ensembl website (http://www.ensembl.org/Homo_sapiens/Gene/Splice?db=core;g=ENSG00000141736;r=17:39687914-39730426). 
  
  # import the csv table downloaded from ensembl website for the specific gene. Said table contains 
  # all the isoforms of the gene. 
  
  ensembl_table <- read_xlsx(paste("cartcontent/data/isoforms/transcripts_", hgnc, ".xlsx", sep = ""), 
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
  
  # import deeptmhmm output
  deeptmhmm_output <- read.table(paste("cartcontent/results/Deeptmhmm/canonical_and_isoforms/", hgnc, sep = ""), fill = T)
  
  #wrangling --> removing unused columns, making tibble with 3 columns: isoform name, sequence and prediction.
  deeptmhmm_output <- deeptmhmm_output %>% dplyr::select(-V2, -V3) 
  
  names_index <- seq(from = 1, to = nrow(deeptmhmm_output), by = 3)
  sequence_index <- seq(from = 2, to = nrow(deeptmhmm_output), by = 3)
  prediction_index <- seq(from = 3, to = nrow(deeptmhmm_output), by = 3)
  
  deeptmhmm_output <- tibble("name" = deeptmhmm_output[names_index, ],
                             "sequence" = deeptmhmm_output[sequence_index, ],
                             "prediction" = deeptmhmm_output[prediction_index, ])
  
  deeptmhmm_output <- deeptmhmm_output %>% 
    separate(., col = "name", into = c(NA, "name", NA), sep = "\\|")
  
  deeptmhmm_output_ensembl <- full_join(ensembl_uniprot_table, deeptmhmm_output, by = "name")
  
  write.table(deeptmhmm_output_ensembl, paste("cartcontent/results/Deeptmhmm/output_enst_", hgnc, ".txt", sep = ""), quote = F, sep = "/t")

  deeptmhmm_output_ensembl <- deeptmhmm_output_ensembl %>% drop_na() # IF THE NAMES OF THE PROTEINS IN THE ENSG FILE AND IN UNIPROT ARE NOT THE SAME, YOU LOSE DATA IN THIS STEP.
  
  # the sequences are not aligned. So I drop the sequence column. I will add the sequences aligned with msa. 
  deeptmhmm_output_ensembl <- deeptmhmm_output_ensembl %>% dplyr::select(-sequence)
  
  # in all the analyses and the plots, I will use the ensembl transcript IDs inside the deeptmhmm_output_ensembl table -->
  # they are protein coding and we have expression data for them.
  
  # import object (created using the msa script)
  aligned_sequences <- read_fasta(paste("cartcontent/results/aligned_sequences/", hgnc, "_msa", sep = ""))
  # wrangle to improve view 
  aligned_sequences <- aligned_sequences %>% 
    separate(., col = "name", into = c(NA, "name", NA), sep = "\\|")
  
  aligned_sequences <- full_join(aligned_sequences, deeptmhmm_output_ensembl, "name") %>% 
    dplyr::select(-prediction) %>% na.omit()
  
  isoform_list <- vector(mode = "list", length = nrow(aligned_sequences))
  
 
  
  
  names(isoform_list) <- aligned_sequences$transcript
  for (i in 1:nrow(aligned_sequences)) {
    isoform_list[[i]] <- aligned_sequences$sq[i]
  }
  
  isoforms <- isoform_list %>% 
    map(function(x) as.character(x)) %>% 
    map(function(x) str_split(x, pattern = "")) %>% 
    map(function(x) as_tibble(x, .name_repair = ~ "seq")) %>% 
    map(function(x) mutate(x, "index" = case_when(seq == "-" ~ 0,
                                                  seq != "-" ~ 1))) %>% 
    map(function(x) mutate(x, test = cumsum(index == 1))) %>% 
    map(function(x) mutate(x, index = ifelse(duplicated(test), 0, test)) %>% dplyr::select(-test))
  
  deeptmhmm_pred <- vector(mode = "list", length = length(isoforms))
  names(deeptmhmm_pred) <- names(isoforms)
  
  for (i in 1:length(isoforms)) {
    isoform_name <- names(deeptmhmm_pred)[i]
    
    deeptmhmm_pred[[isoform_name]] <- deeptmhmm_output_ensembl %>% 
      filter(transcript == isoform_name) %>% #take the sequence of the isoform I am interested in
      dplyr::select(-transcript, -name) %>% 
      as.character() %>% # convert in vector of characters
      str_split(., pattern = "") %>% 
      as_tibble(.name_repair = ~ "prediction") # convert into tibble
    
    deeptmhmm_pred[[isoform_name]] <- deeptmhmm_pred[[isoform_name]] %>% 
      mutate("index" = 1:nrow(deeptmhmm_pred[[isoform_name]])) # add index column. Needed to merge with the aligned sequence. 
  }
  
  aligned_predictions <- vector(mode = "list", length = nrow(aligned_sequences))
  names(aligned_predictions) <- names(isoforms)
  
  ranges <- vector(mode = "list", length = nrow(aligned_sequences))
  names(ranges) <- names(isoforms)
  
  for (i in 1:length(isoforms)) {
    isoform_name <- names(aligned_predictions)[i]
    
    aligned_predictions[[isoform_name]] <- full_join(x = isoforms[[isoform_name]], 
                                                     y = deeptmhmm_pred[[isoform_name]], 
                                                     by = "index") %>% 
      replace_na(list(prediction = "-")) 
    
    aligned_predictions[[isoform_name]] <- aligned_predictions[[isoform_name]] %>% 
       dplyr::select(prediction) %>% 
       mutate(index = 1:nrow(aligned_predictions[[isoform_name]])) %>% 
      as.data.frame() # as df because with tibbles the following does not work
    
    gap <- aligned_predictions[[isoform_name]][aligned_predictions[[isoform_name]]$prediction == "-", "index"]
    signal <- aligned_predictions[[isoform_name]][aligned_predictions[[isoform_name]]$prediction == "S", "index"]
    outer <- aligned_predictions[[isoform_name]][aligned_predictions[[isoform_name]]$prediction == "O", "index"]
    tm <- aligned_predictions[[isoform_name]][aligned_predictions[[isoform_name]]$prediction == "M", "index"]
    inner <- aligned_predictions[[isoform_name]][aligned_predictions[[isoform_name]]$prediction == "I", "index"]
    
    start_gap <- gap[c(TRUE,diff(gap)!=1)]
    start_signal <- signal[c(TRUE,diff(signal)!=1)]
    start_outer <- outer[c(TRUE,diff(outer)!=1)]
    start_tm <- tm[c(TRUE,diff(tm)!=1)]
    start_inner <- inner[c(TRUE,diff(inner)!=1)]
    
    end_gap <- gap[c(diff(gap)!=1, TRUE)]
    end_signal <- signal[c(diff(signal)!=1, TRUE)]
    end_outer <- outer[c(diff(outer)!=1, TRUE)]
    end_tm <- tm[c(diff(tm)!=1, TRUE)]
    end_inner <- inner[c(diff(inner)!=1, TRUE)]
    
    ranges_gap <- tibble(topology = "-", start = start_gap, end = end_gap, bin = rep(i, length(start_gap)))
    ranges_signal <- tibble(topology = "S", start = start_signal, end = end_signal, bin = rep(i, length(start_signal)))
    ranges_outer <- tibble(topology = "O", start = start_outer, end = end_outer, bin = rep(i, length(start_outer)))
    ranges_tm <- tibble(topology = "M", start = start_tm, end = end_tm, bin = rep(i, length(start_tm)))
    ranges_inner <- tibble(topology = "I", start = start_inner, end = end_inner, bin = rep(i, length(start_inner)))
    
    ranges[[isoform_name]] <- rbind(ranges_gap, ranges_signal, ranges_outer, ranges_tm, ranges_inner) %>% 
      arrange(start) %>% 
      na.omit()
  } 
  
  ranges_df <- bind_rows(ranges)
  
  transcript_names <- as_tibble(names(isoforms), .name_repair = ~ "transcripts")
  
  saveRDS(ranges_df, paste("cartcontent/results/ranges", hgnc, ".rds", sep = ""))
  
  ranges_df$topology <- factor(ranges_df$topology, levels=c("S", "O", "M", "I", "-"), 
                            labels=c('Signal peptide','Outside','Trans membrane','Inside','Alignment gap'))
  
 
   plot <- ranges_df %>% 
     ggplot(aes(xmin = start, xmax = end,  ymin = bin + 0.1, ymax = bin + 0.9, fill = topology)) +
    geom_rect() +
    scale_y_continuous(limits = c(0.9, nrow(transcript_names) + 1.1), expand = c(0, 0), 
                        breaks = 1:(length(transcript_names$transcripts)) + 0.5, 
                        labels = transcript_names$transcripts, 
                        name = "Isoform ID (ENST)") +
    ggtitle("Protein topologies") +
    scale_fill_manual(values=c("#C41C24", "#FFB20F", "#18848C", "#96BDC6", "#EDE7E3")) +
    xlab("Amino acid position in multiple sequence alignment") +
    theme_bw() +
    labs(fill = "Protein topology") +
    theme(axis.ticks = element_blank(), 
          plot.title = element_text(size = 16),
          axis.text.y = element_text(size = 11),
          axis.text.x = element_text(size = 10),
          axis.title = element_text(size = 12))
   
   ggsave(filename = paste(hgnc, "_plot_isoforms.pdf", sep = ""), plot = plot, device = "pdf", 
          path = "cartcontent/results/plots/protein_properties/", width = 30, height = 12, units = "cm")
  
  return(plot)
}



# #retrieve the ensembl gene ID from the hugo gene symbol 
# ensgID <- hgnc_from_ensembl %>% 
#   filter(hgnc_symbol == hgnc) %>% 
#   pull(ensembl_gene_id)
# 
# #retrieve the ensg transcripts names
# enst <- gte_list %>% 
#   pluck(ensgID) %>% 
#   names()
# # the isoform sequences can be downloaded from uniprot (canonical + isoforms) and saved in a txt file. Said
# # file is then used as input in deeptmhmm. 
# # in the analyses we are retaining only the protein coding isoforms. The information can be 
# # found and downloaded from the ensembl website (http://www.ensembl.org/Homo_sapiens/Gene/Splice?db=core;g=ENSG00000141736;r=17:39687914-39730426). 
# 
# # import the csv table downloaded from ensembl website for the specific gene. Said table contains 
# # all the isoforms of the gene. 
# 
# ensembl_table <- read_xlsx("cartcontent/data/isoforms/transcripts_ERBB2.xlsx", 
#                            col_names = TRUE, skip = 1) # skip = 1 is necessary to have colnames

# 
# # check that the main isoform does not have the -1 in the name
# View(ensembl_table)
# # eliminate the version number from transcripts 
# ensembl_table <- ensembl_table %>% separate(., col = `Transcript ID`, into = c("transcript", NA), sep = "\\.")
# ensembl_table <- ensembl_table %>% filter(grepl("Protein coding",Biotype))
# ensembl_table <- ensembl_table %>% dplyr::select(transcript, `UniProt Match`)
# 
# # convert the vector enst into a 1 column tibble
# enst <- as_tibble_col(enst, column_name = "transcript")
# 
# # join the two tables retaining only the transcripts that are in common (--> protein coding in ensembl
# # and in the gte_list object)
# 
# ensembl_uniprot_table <- semi_join(ensembl_table, enst, by = "transcript") 
# colnames(ensembl_uniprot_table)[2] <- "name"
# 
# # import deeptmhmm output
# deeptmhmm_output <- read.table("cartcontent/results/Deeptmhmm/canonical_and_isoforms/ERBB2", fill = T)
# 
# #wrangling --> removing unused columns, making tibble with 3 columns: isoform name, sequence and prediction.
# deeptmhmm_output <- deeptmhmm_output %>% dplyr::select(-V2, -V3) 
# 
# names_index <- seq(from = 1, to = nrow(deeptmhmm_output), by = 3)
# sequence_index <- seq(from = 2, to = nrow(deeptmhmm_output), by = 3)
# prediction_index <- seq(from = 3, to = nrow(deeptmhmm_output), by = 3)
# 
# deeptmhmm_output <- tibble("name" = deeptmhmm_output[names_index, ],
#                            "sequence" = deeptmhmm_output[sequence_index, ],
#                            "prediction" = deeptmhmm_output[prediction_index, ])
# 
# deeptmhmm_output <- deeptmhmm_output %>% 
#   separate(., col = "name", into = c(NA, "name", NA), sep = "\\|")
# 
# deeptmhmm_output_ensembl <- full_join(ensembl_uniprot_table, deeptmhmm_output, by = "name")

# end of function
# save the table and look at it before removing the NAs and check if the names/match are correct

# deeptmhmm_output_ensembl <- deeptmhmm_output_ensembl %>% drop_na()
# 
# # the sequences are not aligned. So I drop the sequence column. I will add the sequences aligned with msa. 
# deeptmhmm_output_ensembl <- deeptmhmm_output_ensembl %>% dplyr::select(-sequence)
# 
# # in all the analyses and the plots, I will use the ensembl transcript IDs inside the deeptmhmm_output_ensembl table -->
# # they are protein coding and we have expression data for them.
# 
# # import object (created using the msa script)
# aligned_sequences <- read_fasta("cartcontent/results/ERBB2_msa")
# 
# # wrangle to improve view (one isoform for now)
# 
# aligned_sequences <- aligned_sequences %>% 
#   separate(., col = "name", into = c(NA, "name", NA), sep = "\\|")

# f5h1t4 <- aligned_sequences$sq[1] %>% as.character()
# f5h1t4 <- str_split(f5h1t4, pattern = "")
# f5h1t4 <- f5h1t4 %>% 
#   as_tibble(., "seq") 
# colnames(f5h1t4)[1] <- "seq"
# f5h1t4 <- f5h1t4 %>% 
#   mutate("index" = case_when(seq == "-" ~ 0, 
#                              seq != "-" ~ 1))
# 
# f5h1t4 <- f5h1t4 %>% 
#   mutate(test = cumsum(index == 1)) 
# 
# f5h1t4 <- f5h1t4 %>% mutate(index = ifelse(duplicated(test), 0, test)) %>% dplyr::select(-test)



# make tibble with prediction of topology of the same sequence
# 
# f5h1t4_pred <- deeptmhmm_output_ensembl %>% 
#   filter(name == aligned_sequences$name[1]) %>% #take the sequence of the isoform I am interested in
#   dplyr::select(-transcript, -name) %>% 
#   as.character() %>% # convert in vector of characters
#   str_split(., pattern = "") %>% 
#   as_tibble("prediction") # convert into tibble
# 
# colnames(f5h1t4_pred) <- "prediction"
# 
# # add column of 1s. Needed to merge with the aligned sequence. 
# 
# f5h1t4_pred <- f5h1t4_pred %>% 
#   mutate("index" = 1:nrow(f5h1t4_pred))
# 
# f5h1t4_tot <- full_join(x = f5h1t4, y = f5h1t4_pred, "index") 
# 
# f5h1t4_tot <- f5h1t4_tot %>% replace_na(list(prediction = "-"))
# 
# 
# f5h1t4_pred <- f5h1t4_tot %>% dplyr::select(prediction) %>% mutate(index = 1:nrow(f5h1t4_tot))








test <- c(rep("-", 10), rep("S", 15), rep("-", 3), rep("O", 20), rep("M", 5), rep("I", 14))

testtib <- tibble(prediction = test)
testtib <- testtib %>% mutate(index = 1:nrow(testtib)) %>% as.data.frame()

gap <- testtib[testtib$prediction == "-", "index"]
signal <- testtib[testtib$prediction == "S", "index"]
outer <- testtib[testtib$prediction == "O", "index"]
tm <- testtib[testtib$prediction == "M", "index"]
inner <- testtib[testtib$prediction == "I", "index"]

start_gap <- gap[c(TRUE,diff(gap)!=1)]
start_signal <- signal[c(TRUE,diff(signal)!=1)]
start_outer <- outer[c(TRUE,diff(outer)!=1)]
start_tm <- tm[c(TRUE,diff(tm)!=1)]
start_inner <- inner[c(TRUE,diff(inner)!=1)]

end_gap <- gap[c(diff(gap)!=1, TRUE)]
end_signal <- signal[c(diff(signal)!=1, TRUE)]
end_outer <- outer[c(diff(outer)!=1, TRUE)]
end_tm <- tm[c(diff(tm)!=1, TRUE)]
end_inner <- inner[c(diff(inner)!=1, TRUE)]

ranges_gap <- tibble(topology = "-", start = start_gap, end = end_gap, bin = rep(1, length(start_gap)))
ranges_signal <- tibble(topology = "S", start = start_signal, end = end_signal, bin = rep(1, length(start_signal)))
ranges_outer <- tibble(topology = "O", start = start_outer, end = end_outer, bin = rep(1, length(start_outer)))
ranges_tm <- tibble(topology = "M", start = start_tm, end = end_tm, bin = rep(1, length(start_tm)))
ranges_inner <- tibble(topology = "I", start = start_inner, end = end_inner, bin = rep(1, length(start_inner)))

ranges <- rbind(ranges_gap, ranges_signal, ranges_outer, ranges_tm, ranges_inner) %>% 
  arrange(start)

ranges$topology <- factor(ranges$topology, levels=c("S", "O", "M", "I", "-"), 
                          labels=c('Signal peptide','Outside','Trans membrane','Inside','Alignment gap'))
t <- ggplot(ranges, aes(xmin=start, xmax=end,  ymin = bin + 0.1, ymax = bin + 0.9, fill=topology)) +
  scale_y_continuous(limits = c(0.9, max(ranges$bin)+1.1), expand = c(0, 0)) +
  geom_rect() +
  ggtitle("Protein topologies") +
  scale_fill_manual(values=c("#904E55", "#FFA62B", "#489FB5", "#16697A", "#EDE7E3")) +
  xlab("Amino acid position in multiple sequence alignment") +
  theme_bw() +
  labs(fill = "Protein topology") +
  theme(axis.ticks = element_blank(), axis.text.y = element_blank())











