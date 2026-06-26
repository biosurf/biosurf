# script for MAFFT alignemnt and epitope residue analysis between ERBB family members

library(biomaRt)
library(Biostrings)
library(tidyverse)
library(ggnewscale)

options(timeout = 300)

# Connect to Ensembl
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl", 
                      mirror = "uswest")

genes <- c("ERBB2", "ERBB3", "ERBB4", "EGFR")

# Step 1: Get canonical transcript IDs (lightweight query)
canonical_ids <- getBM(
  attributes = c("hgnc_symbol", "ensembl_transcript_id", "transcript_is_canonical"),
  filters = "hgnc_symbol",
  values = genes,
  mart = ensembl
) %>%
  filter(transcript_is_canonical == 1)

cat("Canonical transcripts:\n")
print(canonical_ids)

# Step 2: Fetch peptide sequences separately
seqs <- getBM(
  attributes = c("ensembl_transcript_id", "peptide"),
  filters = "ensembl_transcript_id",
  values = canonical_ids$ensembl_transcript_id,
  mart = ensembl
) %>%
  filter(peptide != "")

# Merge gene names back
seqs <- seqs %>%
  left_join(canonical_ids %>% select(hgnc_symbol, ensembl_transcript_id),
            by = "ensembl_transcript_id")

# Build AAStringSet
sequences <- AAStringSet(seqs$peptide)
names(sequences) <- paste0(seqs$hgnc_symbol, "_", seqs$ensembl_transcript_id)

cat("\nSequences retrieved:\n")
print(sequences)

# Align with MAFFT (same method as vignette)
temp_input <- tempfile(fileext = ".fasta")
temp_output <- tempfile(fileext = ".fasta")

writeXStringSet(sequences, temp_input)

system2("mafft",
        args = c("--localpair", "--maxiterate", "1000", "--quiet", temp_input),
        stdout = temp_output)

aligned <- readAAStringSet(temp_output)
aligned <- readAAStringSet("cartcontent/results/HER2_analysis/erbb_family_canonical_aligned.fasta")
unlink(c(temp_input, temp_output))

cat("\nAlignment width:", unique(width(aligned)), "positions\n")
print(aligned)


# Epitope positions in canonical HER2 (same as vignette)
epitope_positions <- list(
  P = list(c(257, 267), c(308, 318)),
  T = list(c(580, 582), c(593, 595), c(610, 625))
)

# Find the HER2 canonical name in the alignment
her2_name <- names(aligned)[str_detect(names(aligned), "ERBB2")]

# Map epitopes across all 4 family members
epitope_mapping <- map_epitopes_from_alignment( # this function is defined in the HER2 coding vignette 
  aligned_seqs = aligned,
  canonical_name = her2_name,
  epitope_pos = epitope_positions
)

# Summary: how many epitope positions are retained per gene
epitope_summary <- epitope_mapping %>%
  group_by(transcript_id, epitope) %>%
  summarise(n_positions = n(), .groups = "drop") %>%
  pivot_wider(names_from = epitope, values_from = n_positions, values_fill = 0)

print(epitope_summary)



# Get the HER2 sequence from the alignment as reference
her2_seq <- strsplit(as.character(aligned[[her2_name]]), "")[[1]]

# Add the actual amino acids and conservation info to epitope_mapping
epitope_detail <- epitope_mapping %>%
  mutate(
    aa = map2_chr(transcript_id, position, function(tid, pos) {
      strsplit(as.character(aligned[[tid]]), "")[[1]][pos]
    }),
    her2_aa = her2_seq[position],
    changed = aa != her2_aa
  )

# Add a region label for faceting
epitope_detail <- epitope_detail %>%
  mutate(region = ifelse(epitope == "P", "Pertuzumab epitope", "Trastuzumab epitope"),
         region = factor(region, levels = c("Pertuzumab epitope", "Trastuzumab epitope")))

# Build substitution table
her2_seq <- strsplit(as.character(aligned[[her2_name]]), "")[[1]]

substitution_table <- epitope_mapping %>%
  mutate(
    aa = map2_chr(transcript_id, position, function(tid, pos) {
      strsplit(as.character(aligned[[tid]]), "")[[1]][pos]
    }),
    her2_aa = her2_seq[position]
  ) %>%
  filter(transcript_id != her2_name) %>%
  select(transcript_id, epitope, canonical_pos, her2_aa, aa) %>%
  mutate(changed = aa != her2_aa)

# Wide format: one row per position, columns per family member
substitution_wide <- substitution_table %>%
  select(epitope, canonical_pos, her2_aa, transcript_id, aa) %>%
  pivot_wider(names_from = transcript_id, values_from = aa)

print(substitution_wide, n = Inf)

#BLOSUM62 substitution scoring
# Load the BLOSUM62 matrix
data(BLOSUM62)

substitution_table_scored <- substitution_table %>%
  filter(aa != "-") %>%
  rowwise() %>%
  mutate(
    blosum62 = BLOSUM62[her2_aa, aa]
  ) %>%
  ungroup()

# View only the substitutions with scores
substitution_table_scored %>%
  filter(changed) %>%
  select(transcript_id, epitope, canonical_pos, her2_aa, aa, blosum62) %>%
  print(n = Inf)

# Interpretation: identical residues score highest (4–11 depending on the amino acid), 
# positive scores are conservative substitutions, negative scores are biochemically 
# dissimilar and unlikely to preserve binding. 
# If most epitope contact positions show negative BLOSUM62 scores across HER3/HER4/EGFR, 
# that's already strong evidence against off-target binding.


##### To update: add a line connecting the epitope sequences to minimize white 
# space in the figure and illustrate that we are "skipping" over that region analytically and the space between epitopes is not to scale
# add the BLOSUM62 scores







# 
# ## PLOT
# # Prepare BLOSUM62 labels matched to the focused plot below
# blosum_labels <- substitution_table_scored %>%
#   filter(changed) %>%
#   mutate(
#     region = ifelse(epitope == "P", "Pertuzumab epitope", "Trastuzumab epitope"),
#     region = factor(region, levels = c("Pertuzumab epitope", "Trastuzumab epitope"))
#   ) %>%
#   select(transcript_id, canonical_pos, blosum62, region)
# 
# blosum_labels <- substitution_table_scored %>%
#   filter(changed) %>%
#   mutate(
#     region = ifelse(epitope == "P", "Pertuzumab epitope", "Trastuzumab epitope"),
#     region = factor(region, levels = c("Pertuzumab epitope", "Trastuzumab epitope")),
#     score_color = ifelse(blosum62 < 0, "#b33030", "grey30")
#   ) %>%
#   select(transcript_id, canonical_pos, blosum62, region, score_color)
# 
# # Add to the plot
# focused <- ggplot(epitope_detail, aes(x = canonical_pos, y = transcript_id)) +
#   geom_tile(aes(fill = interaction(epitope, changed)), height = 0.8) +
#   geom_text(aes(label = aa), size = 3, nudge_y = 0.1) +
#   geom_text(
#     data = blosum_labels,
#     aes(x = canonical_pos, y = transcript_id, label = blosum62, color = score_color),
#     inherit.aes = FALSE,
#     size = 3.5, fontface = "bold", nudge_y = -0.2,
#     show.legend = FALSE
#   ) +
#   scale_color_identity() +
#   scale_fill_manual(
#     values = c(
#       "P.FALSE" = "#b7e4c7",
#       "P.TRUE"  = "#55a630",
#       "T.FALSE" = "#ffb3c6",
#       "T.TRUE"  = "#ff5d8f"
#     ),
#     labels = c(
#       "P.FALSE" = "Pertuzumab – conserved",
#       "P.TRUE"  = "Pertuzumab – substituted",
#       "T.FALSE" = "Trastuzumab – conserved",
#       "T.TRUE"  = "Trastuzumab – substituted"
#     ),
#     name = "Epitope"
#   ) +
#   facet_grid(~ region, scales = "free_x", space = "free_x") +
#   labs(
#     x = "HER2 canonical position",
#     y = NULL,
#     title = "Epitope residue conservation across ERBB family",
#     caption = "Numbers below residues: BLOSUM62 substitution scores (positive = conservative, negative = biochemically dissimilar)"
#   ) +
#   theme_minimal() +
#   theme(
#     axis.text.y = element_text(size = 12),
#     axis.text.x = element_text(size = 7, angle = 45, hjust = 1),
#     panel.grid = element_blank(),
#     strip.text = element_text(size = 11, face = "bold"),
#     panel.spacing = unit(1, "cm"),
#     plot.caption = element_text(size = 9, hjust = 0, color = "grey40")
#   )
# 
# ggsave(plot = focused, filename = "cartcontent/results/HER2_analysis/figures/Fig5_erbb_fam_aligned_mafft_epitope_region.pdf", device = "pdf", width = 25, height = 4)
# 
# 
# # Save outputs
# write_csv(substitution_wide, "cartcontent/results/HER2_analysis/epitope_substitution_table.csv")
# writeXStringSet(sequences, "cartcontent/results/HER2_analysis/erbb_family_canonical.fasta")
# writeXStringSet(aligned, "cartcontent/results/HER2_analysis/erbb_family_canonical_aligned.fasta")
# cat("\nSaved: erbb_family_canonical.fasta and erbb_family_canonical_aligned.fasta\n")
# 








p_levels <- build_levels(epitope_detail$canonical_pos[epitope_detail$epitope == "P"], n_spacers = 5)
t_levels <- build_levels(epitope_detail$canonical_pos[epitope_detail$epitope == "T"], n_spacers = 5)
all_levels <- unique(c(p_levels, t_levels))


spacer_df <- bind_rows(
  tibble(canonical_pos_f = factor(p_levels[grepl("^spacer_", p_levels)], levels = all_levels),
         region = "Pertuzumab epitope", epitope = "P"),
  tibble(canonical_pos_f = factor(t_levels[grepl("^spacer_", t_levels)], levels = all_levels),
         region = "Trastuzumab epitope", epitope = "T")
) %>%
  mutate(transcript_id = epitope_detail$transcript_id[1],   # any valid transcript, just to anchor the column
         aa = NA_character_,
         changed = NA)

epitope_detail <- epitope_detail %>%
  mutate(canonical_pos_f = factor(as.character(canonical_pos), levels = all_levels))

rename_map <- c("ERBB2" = "HER2", "ERBB3" = "HER3", "ERBB4" = "HER4", "EGFR" = "EGFR")
level_order <- rev(c("HER2", "HER3", "HER4", "EGFR"))

epitope_detail_full <- epitope_detail_full %>%
  mutate(
    gene_label = str_extract(transcript_id, "^[A-Z0-9]+"),
    gene_label = recode(gene_label, !!!rename_map),
    gene_label = factor(gene_label, levels = level_order)
  )

blosum_labels_f <- blosum_labels_f %>%
  mutate(
    gene_label = str_extract(transcript_id, "^[A-Z0-9]+"),
    gene_label = recode(gene_label, !!!rename_map),
    gene_label = factor(gene_label, levels = level_order)
  )

focused <- ggplot(epitope_detail_full, aes(x = canonical_pos_f, y = gene_label)) +
  geom_tile(aes(fill = interaction(epitope, changed)), height = 0.8) +
  geom_text(aes(label = aa), size = 4.5, nudge_y = 0.1, na.rm = TRUE) +
  geom_text(
    data = blosum_labels_f,
    aes(x = canonical_pos_f, y = gene_label, label = blosum62, color = score_color),
    inherit.aes = FALSE, size = 4.5, fontface = "bold", nudge_y = -0.2,
    show.legend = FALSE
  ) +
  scale_color_identity() +
  scale_fill_manual(
    values = c("P.FALSE" = "#b7e4c7", "P.TRUE" = "#55a630",
               "T.FALSE" = "#ffb3c6", "T.TRUE" = "#ff5d8f"),
    labels = c(
      "P.FALSE" = "Pertuzumab - conserved",
      "P.TRUE"  = "Pertuzumab - substituted",
      "T.FALSE" = "Trastuzumab - conserved",
      "T.TRUE"  = "Trastuzumab - substituted"
    ),
    na.translate = FALSE,
    name = "Epitope"
  ) +
  scale_x_discrete(breaks = all_levels, labels = label_map) +
  facet_grid(~ region, scales = "free_x", space = "free_x") +
  labs(x = "HER2 canonical position", y = "Transcript ID") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
    axis.text.y = element_text(size = 13),
    axis.title = element_text(size = 14),
    legend.text = element_text(size = 12),
    legend.title = element_text(size = 13),
    strip.text = element_text(size = 13, face = "bold"),
    panel.grid = element_blank(),
    panel.spacing = unit(0.8, "cm")
  )


ggsave(plot = focused, filename = "cartcontent/results/HER2_analysis/figures/Fig5_erbb_fam_aligned_mafft_epitope_region.pdf", device = "pdf", width = 18, height = 4)






