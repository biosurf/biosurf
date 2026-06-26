#
#Script to visualize the expression of HER2 isoforms
#

#Load libraries
# Load necessary libraries
library(tidyverse, quietly = T, verbose = F)
library(wesanderson, quietly = T, verbose = F)
library(patchwork, quietly = T, verbose = F)
library(readxl, quietly = T, verbose = F)

#
# OBS: Before you start: Make sure the working directory is set to the folder where the data files are located.
#
setwd("~/Desktop/Lasse Desktop/Undervisning DTU/Exercise_2_isoforms")

#
# Load the saved data
# 

load("cartcontent/data/old/HER2_isoform_expression_Lasse.Rdata")

#
#Now run the function
# 



# select the tissues and cancer of interest and find isoforms expression in those tissues
HER2_isoforms <- isoforms_selected_tissues(hgnc = "ERBB2", 
                                           TCGA_interest = c("glioblastoma multiforme", "colon adenocarcinoma", "lung squamous cell carcinoma", 
                                                             "lung adenocarcinoma", "breast invasive carcinoma", "stomach adenocarcinoma", 
                                                             "liver hepatocellular carcinoma", "pancreatic adenocarcinoma", "rectum adenocarcinoma"), 
                                           GTEX_interest = c("heart", "kidney", "liver", "lung", "brain", "skin", "pancreas", "colon", "bladder", "muscle", "stomach"), 
                                           gte_list = gte_list, 
                                           pheno = pheno_nh, 
                                           enst_expr = enst_expr, 
                                           hgnc_from_ensembl = hgnc_from_ensembl, 
                                           ensembl_table = HER2_transcripts)
HER2_isoforms$tcga

median_tcga <- HER2_isoforms$tcga %>%
  group_by(category) %>%
  summarize(median_expression = median(expression_level)) %>%
  arrange(desc(median_expression))

# Reorder the categories based on the median expression levels
HER2_isoforms$tcga$category <- factor(HER2_isoforms$tcga$category, 
                                      levels = median_tcga$category)

# plot the tcga and gtex of interest
lt <- HER2_isoforms$gtex$enst_id %>% unique() %>% length()
palette <- wes_palette("FantasticFox1", lt, "continuous")

plot_tcga <- ggplot(HER2_isoforms$tcga,
                    mapping = aes(x = category, y = expression_level, fill = enst_id)) +
  geom_boxplot(alpha = 0.9, outlier.shape = NA, width = 0.9) +
  scale_fill_manual(values = palette) +
  ylim(0, 8) +
  theme_light() +
  xlab(" ") +
  ylab("Log2(TPM)") +
  theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 10),
        axis.text.y = element_text(size = 10),
        axis.title = element_text(size = 10),
        plot.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 10),
        plot.margin = unit(c(1,1,1,3), "cm"),
        legend.position = "bottom") +
  ggtitle(label = "HER2 expression for TCGA cancers")



# Repeat the same process for GTEX data
median_gtex <- HER2_isoforms$gtex %>%
  group_by(category) %>%
  summarize(median_expression = median(expression_level)) %>%
  arrange(desc(median_expression))

# Reorder the categories for GTEX based on the median expression levels
HER2_isoforms$gtex$category <- factor(HER2_isoforms$gtex$category, 
                                      levels = median_gtex$category)


plot_gtex <- ggplot(HER2_isoforms$gtex,
                    mapping = aes(x = category, y = expression_level, fill = enst_id)) +
  geom_boxplot(alpha = 0.9, outlier.shape = NA, width = 0.9) +
  scale_fill_manual(values = palette) +
  ylim(0, 8) +
  theme_light() +
  xlab(" ") +
  ylab("Log2(TPM)") +
  theme(axis.text.x = element_text(angle = 40, hjust = 1, size = 10),
        axis.text.y = element_text(size = 10),
        axis.title = element_text(size = 10),
        plot.title = element_text(size = 10),
        # legend.text = element_text(size = 30),
        # legend.title = element_text(size = 35),
        plot.margin = unit(c(1,1,1,1), "cm"),
        legend.position = "none") +
  ggtitle(label = paste("HER2 expression for GTEX  normal tissues"))

(plot <- plot_tcga + plot_gtex)



