# CREATION OF TRANSCRIPTS LEVEL BOXPLOT. 

# GOAL: for each gene, to create a set of boxplots with the transcript 
# level of each isoform. 

# import of the files: 
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

# create a boxplot function to have for each gene the expression level of all the isoforms
# in all the tissues

# creating the boxplot function (goal)
boxplot_isoforms_all_tissues <- function(hgnc) {
  hgnc_from_ensembl <- readRDS(file = "cartcontent/results/00_hgnc_from_ensembl_biomart.rds")
  
  #retrieve the ensembl gene ID from the hugo gene symbol 
  ensgID <- hgnc_from_ensembl %>% 
    filter(hgnc_symbol == hgnc) %>% 
    pull(ensembl_gene_id)
  
  #retrieve the ensg transcripts names
  enst <- gte_list %>% 
    pluck(ensgID) %>% 
    names()
  
  # list of tissues/cancers (categories) to which the samples belong
  list_of_categories <- unique(pheno_nh$TCGA_GTEX_main_category) 
  
  # import transcript data from ensembl website --> I want to retain only the protein coding transcripts

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
  
  # create a new enst object, that only contains the protein coding isoforms in gte_list
  enst <- ensembl_uniprot_table$transcript
  
  # filter retaining the transcripts in enst and their expression level in the different samples
  enst_exp_lev <- enst_expr %>% 
    filter(enst_expr$rowname %in% enst) 
  enst_exp_lev <- enst_exp_lev %>% 
    pivot_longer(., cols = colnames(enst_exp_lev)[-1], 
                 names_to = "sample", values_to = "expression_level")
  
  enst_exp_category_tcga <- full_join(enst_exp_lev, pheno_nh, by = "sample") %>% 
    filter(dataset == "tcga") %>% 
    dplyr::select(-(dataset)) # the result is a tibble with the transcript on the rows, while on the columns 
  # there is the expression level of each transcript in each category/sample
  
  enst_exp_category_gtex <- full_join(enst_exp_lev, pheno_nh, by = "sample") %>% 
    filter(dataset == "gtex") %>% 
    dplyr::select(-(dataset)) # the result is a tibble with the transcript on the rows, while on the columns 
  # there is the expression level of each transcript in each category/sample
  
  colnames(enst_exp_category_tcga)[c(1,4)] <- c("enst_id", "category")
  colnames(enst_exp_category_gtex)[c(1,4)] <- c("enst_id", "category")
  
  enst_exp_category_tcga <- enst_exp_category_tcga %>% 
    mutate(expression_level = log2(expression_level + 1))
  enst_exp_category_gtex <- enst_exp_category_gtex %>% 
    mutate(expression_level = log2(expression_level + 1))
  
  lt <- length(enst)
  
  palette <- wes_palette("FantasticFox1", lt, "continuous")

  # plot_tcga <- ggplot(enst_exp_category_tcga,
  #                     mapping = aes(x = category, y = expression_level, fill = enst_id)) +
  #   geom_boxplot(alpha = 0.9, outlier.shape = NA, width = 0.9) +
  #   scale_fill_manual(values = palette) +
  #   ylim(0, max(enst_exp_category_tcga$expression_level)) +
  #   theme_light() +
  #   xlab(" ") +
  #   ylab("Log2(TPM)") +
  #   theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 40),
  #         axis.text.y = element_text(size = 35),
  #         axis.title = element_text(size = 35),
  #         plot.title = element_text(size = 50),
  #         legend.text = element_text(size = 30),
  #         legend.title = element_text(size = 35),
  #         plot.margin = unit(c(1,1,1,5), "cm"),
  #         legend.position = "bottom") +
  #   ggtitle(label = paste("Target isoforms expression for TCGA cancers"))

  plot_tcga <- ggplot(enst_exp_category_tcga,
                      mapping = aes(x = category, y = expression_level, fill = enst_id)) +
    geom_boxplot(alpha = 0.9, outlier.shape = NA, width = 0.9) +
    scale_fill_manual(values = palette) +
    ylim(0, max(enst_exp_category_tcga$expression_level)) +
    theme_light() +
    xlab(" ") +
    ylab("Log2(TPM)") +
    theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 40),
          axis.text.y = element_text(size = 35),
          axis.title = element_text(size = 35),
          plot.title = element_text(size = 50),
          legend.text = element_text(size = 35),
          legend.title = element_text(size = 40),
          plot.margin = unit(c(1,1,1,5), "cm"),
          legend.position = "bottom") +
    ggtitle(label = paste("Target isoforms expression for TCGA cancers"))
  
  plot_gtex <- ggplot(enst_exp_category_gtex,
                      mapping = aes(x = category, y = expression_level, fill = enst_id)) +
    geom_boxplot(alpha = 0.9, outlier.shape = NA, width = 0.9)  +
    scale_fill_manual(values = palette) +
    ylim(0, max(enst_exp_category_gtex$expression_level)) +
    theme_light() +
    xlab(" ") +
    ylab("Log2(TPM)") +
    theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 40),
          axis.text.y = element_text(size = 35),
          axis.title = element_text(size = 35),
          plot.title = element_text(size = 50),
          # legend.text = element_text(size = 30),
          # legend.title = element_text(size = 35),
          plot.margin = unit(c(1,1,1,5), "cm"), 
          legend.position = "none") +
    ggtitle(label = paste("Target isoforms expression for GTEX  normal tissues"))

  plot <- plot_tcga / plot_gtex

  ggsave(filename = paste(hgnc, "_", ensgID, "_plot.pdf", sep = ""), plot = plot, device = "pdf",
         path = "cartcontent/results/plots/isoform_expression/",
         width = 150, height = 100, units = "cm", limitsize = F)


  return(plot)
}

# -------------------------------------------------------------------------------------------------
# PLOT OF PROTEIN PROPERTIES
plot_function <- function(hgnc) {
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
  aligned_sequences <- read_fasta(paste("cartcontent/results/aligned_sequences/", hgnc, "_msa.txt", sep = ""))
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
    scale_fill_manual(values=c('Signal peptide' = "#C41C24", 'Outside' = "#FFB20F", 
                               'Trans membrane' = "#18848C", 'Inside' = "#96BDC6", 
                               'Alignment gap' = "#EDE7E3")) +
    xlab("Amino acid position in multiple sequence alignment") +
    theme_bw() +
    labs(fill = "Protein topology") +
    theme(axis.ticks = element_blank(), 
          plot.title = element_text(size = 16),
          axis.text.y = element_text(size = 11),
          axis.text.x = element_text(size = 10),
          axis.title = element_text(size = 12))
  
  
  if(length(enst) < 5) {
    ggsave(filename = paste(hgnc, "_plot_isoforms.pdf", sep = ""), plot = plot, device = "pdf", 
           path = "cartcontent/results/plots/protein_properties/", width = 30, height = 8, units = "cm")
  } else {
  ggsave(filename = paste(hgnc, "_plot_isoforms.pdf", sep = ""), plot = plot, device = "pdf", 
         path = "cartcontent/results/plots/protein_properties/", width = 30, height = 12, units = "cm")
  }
  return(plot)
  
}
# ------------------------------------------------------------------------------

# TARGET ESSENTIALITY

# goal: to create a boxplot for each gene, describing the essentiality of the gene
# across different cancers. 
# IMPORTANT: info on the target essentiality table can be read in the target_essentiality.R script, 
# which must be executed before the cart.Rmd, since it creates the crispr_target_essentiality.rds, 
# containing the essentiality scores. 

crispr <- readRDS(file = "crispr_target_essentiality.rds")
# convert the cell_line column content from uppercase to lowcase.
crispr <- crispr %>% mutate(cell_line = tolower(cell_line))
  
target_essentiality_fun <- function(gene_name_hgnc) {
  gene <- crispr %>% filter(gene_name == gene_name_hgnc)

# convert the column cell_line in the column cancer, describing only the cancer type +
# remove the "_" pattern from the cancer names. 
  gene <- gene %>% 
    separate(col = "cell_line", into = c(NA, "cancer"), extra = "merge") %>% 
    mutate(cancer = str_replace_all(string = cancer, pattern = "_", replacement = " ")) 
  
# finding the number of cancer types in the gene table to establish 
# how many colors to use in the ggplot
   cancer_numb <- gene %>% 
    dplyr::select(cancer) %>% 
    unique() %>% 
    nrow()
  
  palette <- wes_palette(name = "GrandBudapest2", type = "continuous", n = cancer_numb)

# plot creation
  
 plot <- gene %>% ggplot(mapping = aes(x = cancer, y = dependency, fill = cancer)) +
            geom_boxplot(width = 0.8, width.errorbar = 0.3, alpha = 0.9, outlier.shape = NA)  +
            scale_fill_manual(values = palette) +
            theme_light() +
            xlab(" ") +
            ylab("essentiality score") +
            theme(axis.text.x = element_text(angle = 60, hjust = 1, size = 24),
                  axis.text.y = element_text(size = 24),
                  axis.title = element_text(size = 30),
                  plot.title = element_text(size = 35),
                  # legend.text = element_text(size = 18), 
                  # legend.title = element_text(size = 20),
                  plot.margin = unit(c(2,2,2,2), "cm"), 
                  legend.position = "none") +
            ggtitle(label = paste("Essentiality scores for TCGA cancers")) 
  
 ggsave(filename = paste(gene_name_hgnc, "_plot.pdf", sep = ""), plot = plot, device = "pdf", 
        path = "cartcontent/results/plots/target_essentiality/", width = 42, height = 30, units = "cm")
 
 return(plot)

}