# CD19 thesis plot topological properties
# PLOT OF PROTEIN PROPERTIES

library(tidyverse)
library(tibble)
library(janitor)
library(wesanderson)
library(biomaRt)
library(patchwork)
library(Ipaper)
library(tidysq) #read fasta file
library(readxl)

hgnc <- "CD19"
  hgnc_from_ensembl <- readRDS(file = "cartcontent/results/00_hgnc_from_ensembl_biomart.rds")
  
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
  deeptmhmm_output <- read.table("cartcontent/results/Deeptmhmm/canonical_and_isoforms/CD19_thesis", fill = T)
  
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
  
  # deeptmhmm_output_ensembl <- full_join(ensembl_uniprot_table, deeptmhmm_output, by = "name")
  
  write.table(deeptmhmm_output, "cartcontent/results/Deeptmhmm/output_CD19_thesis.txt")
  
  # deeptmhmm_output <- deeptmhmm_output_ensembl %>% drop_na() # IF THE NAMES OF THE PROTEINS IN THE ENSG FILE AND IN UNIPROT ARE NOT THE SAME, YOU LOSE DATA IN THIS STEP.
  
  # the sequences are not aligned. So I drop the sequence column. I will add the sequences aligned with msa. 
  deeptmhmm_output <- deeptmhmm_output %>% dplyr::select(-sequence)
  
  # in all the analyses and the plots, I will use the ensembl transcript IDs inside the deeptmhmm_output_ensembl table -->
  # they are protein coding and we have expression data for them.
  
  # import object (created using the msa script)
  aligned_sequences <- read_fasta("cartcontent/results/aligned_sequences/CD19_thesis_msa.txt")
  # wrangle to improve view 
  aligned_sequences <- aligned_sequences %>% 
    tidyr::separate(., col = "name", into = c(NA, "name", NA), sep = "\\|")
  
  aligned_sequences <- full_join(aligned_sequences, deeptmhmm_output, "name") %>% 
    dplyr::select(-prediction) %>% na.omit()
  
  isoform_list <- vector(mode = "list", length = nrow(aligned_sequences))
  names(isoform_list) <- aligned_sequences$name
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
    
    deeptmhmm_pred[[isoform_name]] <- deeptmhmm_output %>% 
      filter(name == isoform_name) %>% #take the sequence of the isoform I am interested in
      dplyr::select(-name) %>% 
      as.character() %>% # convert in vector of characters
      str_split(., pattern = "") %>% 
      as_tibble(.name_repair = ~ "prediction") # convert into tibble
    
    deeptmhmm_pred[[isoform_name]] <- deeptmhmm_pred[[isoform_name]] %>% 
      mutate("index" = 1:nrow(deeptmhmm_pred[[isoform_name]])) # add index column. Needed to merge with the aligned sequence. 
  }
  
  aligned_predictions <- vector(mode = "list", length = nrow(aligned_sequences))
  names(aligned_predictions) <- c(names(isoforms)[2], names(isoforms)[1])
  
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
  
  
  
  # ranges_df <- bind_rows(ranges$P15391_deltaexon2, ranges$P15391)
  ranges_df <- bind_rows(ranges)
  
  transcript_names <- as_tibble(c(names(isoforms)[2], names(isoforms)[1]), .name_repair = ~ "transcripts")
  
  saveRDS(ranges_df, "cartcontent/results/rangesCD19_thesis.rds")
  
  epitope_rows <- data.frame(
    topology = as.factor(c("FMC63_epitope", "FMC63_epitope", "FMC63_epitope", "FMC63_epitope")),
    start = c(153, 214, 153, 214),
    end = c(166, 224, 166, 224),
    bin = c(1, 1, 2, 2)
  )
  
  ranges_df <- rbind(ranges_df, epitope_rows)
  
  ranges_df$topology <- factor(ranges_df$topology, levels=c("S", "O", "M", "I", "-", "FMC63_epitope"), 
                               labels=c('Signal peptide','Ectodomain','Trans membrane','Endodomain','Alignment gap', 'FMC63_epitope'))

  # ranges_df <- ranges_df %>% mutate(bin = case_when(bin == 1 ~ 2,
  #                                                  bin == 2 ~ 1))
  
  (plot <- ranges_df %>% 
    ggplot(aes(xmin = start, xmax = end,  ymin = bin + 0.1, ymax = bin + 0.9, fill = topology)) +
    geom_rect() +
    scale_y_continuous(limits = c(0.9, nrow(transcript_names) + 1.1), expand = c(0, 0), 
                       breaks = 1:(length(transcript_names$transcripts)) + 0.5, 
                       labels = transcript_names$transcripts, 
                       name = "") +
    ggtitle("CD19 variants protein topology") +
    scale_fill_manual(values=c('Signal peptide' = "#C41C24", 'Ectodomain' = "#96BDC6", 
                               'Trans membrane' = "#18848C", 'Endodomain' = "#D3888C", 
                               'Alignment gap' = "#EDE7E3", "FMC63_epitope" = "#fb8500")) +
    xlab("Amino acid position in multiple sequence alignment") +
    theme_bw() +
    labs(fill = "Protein topology") +
    theme(axis.ticks = element_blank(), 
          plot.title = element_text(size = 18),
          axis.text.y = element_text(size = 14),
          axis.text.x = element_text(size = 14),
          axis.title = element_text(size = 16),
          legend.text = element_text(size = 12), 
          legend.title = element_text(size = 14)) ) # Adjust the size here as needed
  
  
  if(length(enst) < 5) {
    ggsave(filename = "CD19_thesis_plot_isoforms.pdf", plot = plot, device = "pdf", 
           path = "cartcontent/results/plots/protein_properties/", width = 30, height = 8, units = "cm")
  } else {
    ggsave(filename = "CD19_thesis_plot_isoforms.pdf", plot = plot, device = "pdf", 
           path = "cartcontent/results/plots/protein_properties/", width = 30, height = 12, units = "cm")
  }
  
