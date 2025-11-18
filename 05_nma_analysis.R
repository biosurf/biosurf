#!/usr/bin/env Rscript
# Normal Mode Analysis (NMA) for CD19 WT vs Δex2 using bio3d
# Predicts intrinsic flexibility/rigidity of epitope regions

rm(list = ls())
library(bio3d)
library(ggplot2)
library(tidyverse)

# Epitope sequences
part1 <- "PKLYVWAKDRPEI"
part2 <- "WTHVHPKGPKS"

# Function to get sequence from PDB
get_pdb_sequence <- function(pdb) {
  # Extract sequence from CA atoms
  ca_inds <- atom.select(pdb, "calpha")
  seq <- pdb$atom$resid[ca_inds$atom]
  
  # Convert 3-letter to 1-letter codes
  aa_dict <- c(
    "ALA" = "A", "CYS" = "C", "ASP" = "D", "GLU" = "E",
    "PHE" = "F", "GLY" = "G", "HIS" = "H", "ILE" = "I",
    "LYS" = "K", "LEU" = "L", "MET" = "M", "ASN" = "N",
    "PRO" = "P", "GLN" = "Q", "ARG" = "R", "SER" = "S",
    "THR" = "T", "VAL" = "V", "TRP" = "W", "TYR" = "Y"
  )
  
  sequence <- paste(sapply(seq, function(x) aa_dict[x]), collapse = "")
  return(sequence)
}

# Function to find epitope positions
find_epitope_positions <- function(sequence, pattern) {
  pos <- regexpr(pattern, sequence, fixed = TRUE)
  if (pos > 0) {
    start <- as.numeric(pos)
    end <- start + nchar(pattern) - 1
    return(list(start = start, end = end))
  }
  return(NULL)
}

# Function to perform NMA
perform_nma <- function(pdb_file, name) {
  cat("\nPerforming NMA on", name, "...\n")
  
  # Read PDB
  pdb <- read.pdb(pdb_file)
  cat("  Found", nrow(pdb$atom[pdb$atom$elety == "CA", ]), "CA atoms\n")
  
  # Select CA atoms
  ca_inds <- atom.select(pdb, "calpha")
  
  # Perform NMA using ANM (Anisotropic Network Model)
  cat("  Running NMA calculation (this may take a moment)...\n")
  nma_result <- nma.pdb(pdb = pdb, inds = ca_inds, ff = "calpha")
  
  # Extract fluctuations (RMSF-like values from normal modes)
  fluctuations <- nma_result$fluctuations
  
  cat("  ✓ NMA complete\n")
  cat("  Mean fluctuation:", sprintf("%.3f", mean(fluctuations)), "Å\n")
  cat("  Median fluctuation:", sprintf("%.3f", median(fluctuations)), "Å\n")
  cat("  Max fluctuation:", sprintf("%.3f", max(fluctuations)), "Å\n")
  
  # Sanity check
  if (mean(fluctuations) > 20) {
    cat("  WARNING: Fluctuations seem high - calculation may have issues\n")
  }
  
  return(list(fluctuations = fluctuations, pdb = pdb, nma = nma_result))
}

cat("======================================================================\n")
cat("NORMAL MODE ANALYSIS: CD19 WT vs Δex2 (using bio3d)\n")
cat("======================================================================\n\n")

cat("This analysis predicts intrinsic flexibility from structure alone\n")
cat("Higher fluctuation values = more flexible/mobile regions\n\n")

# File paths - ADJUST THESE TO YOUR FILES
wt_pdb_path <- "cartcontent/results/CD19 delta exon 2 analysis/Alphafold3_results/cd19_canonical/cd19_canonical_AF_prediction/fold_cd19_canonical_model_0.pdb"
dex2_pdb_path <- "cartcontent/results/CD19 delta exon 2 analysis/Alphafold3_results/cd19_dex2/cd19dex2_AF_prediction2.pdb"

cat("Loading structures to find epitope positions...\n")

# Read structures to get sequences
pdb_wt_seq <- read.pdb(wt_pdb_path)
pdb_dex2_seq <- read.pdb(dex2_pdb_path)

seq_wt <- get_pdb_sequence(pdb_wt_seq)
seq_dex2 <- get_pdb_sequence(pdb_dex2_seq)

cat("WT:", nchar(seq_wt), "residues\n")
cat("Δex2:", nchar(seq_dex2), "residues\n\n")

# Find epitope positions
part1_wt <- find_epitope_positions(seq_wt, part1)
part2_wt <- find_epitope_positions(seq_wt, part2)
part1_dex2 <- find_epitope_positions(seq_dex2, part1)
part2_dex2 <- find_epitope_positions(seq_dex2, part2)

if (is.null(part1_wt) || is.null(part2_wt) || is.null(part1_dex2) || is.null(part2_dex2)) {
  stop("ERROR: Could not find epitope in sequences!")
}

cat("WT epitope positions:\n")
cat("  Part1:", part1_wt$start, "-", part1_wt$end, "\n")
cat("  Part2:", part2_wt$start, "-", part2_wt$end, "\n")
cat("Δex2 epitope positions:\n")
cat("  Part1:", part1_dex2$start, "-", part1_dex2$end, "\n")
cat("  Part2:", part2_dex2$start, "-", part2_dex2$end, "\n")



test <- read.pdb(file = dex2_pdb_path)
test2 <- read.pdb(file = wt_pdb_path)

# Perform NMA on both structures
result_wt <- tryCatch({
  perform_nma(wt_pdb_path, "WT")
}, error = function(e) {
  cat("ERROR in WT NMA:", e$message, "\n")
  return(NULL)
})

result_dex2 <- tryCatch({
  perform_nma(dex2_pdb_path, "Δex2")
}, error = function(e) {
  cat("ERROR in Δex2 NMA:", e$message, "\n")
  return(NULL)
})

if (is.null(result_wt) || is.null(result_dex2)) {
  stop("NMA failed for one or both structures")
}

fluct_wt <- result_wt$fluctuations
fluct_dex2 <- result_dex2$fluctuations

# Extract epitope fluctuations
part1_fluct_wt <- fluct_wt[part1_wt$start:part1_wt$end]
part2_fluct_wt <- fluct_wt[part2_wt$start:part2_wt$end]
part1_fluct_dex2 <- fluct_dex2[part1_dex2$start:part1_dex2$end]
part2_fluct_dex2 <- fluct_dex2[part2_dex2$start:part2_dex2$end]

# Calculate averages
avg_part1_wt <- mean(part1_fluct_wt)
avg_part2_wt <- mean(part2_fluct_wt)
avg_part1_dex2 <- mean(part1_fluct_dex2)
avg_part2_dex2 <- mean(part2_fluct_dex2)

avg_combined_wt <- mean(c(part1_fluct_wt, part2_fluct_wt))
avg_combined_dex2 <- mean(c(part1_fluct_dex2, part2_fluct_dex2))

# Print results
cat("\n")
cat("======================================================================\n")
cat("RESULTS: FLEXIBILITY COMPARISON (NMA Fluctuations)\n")
cat("======================================================================\n\n")

cat("INTERPRETATION GUIDE:\n")
cat("  < 1 Å   = Very rigid (structured core)\n")
cat("  1-3 Å   = Moderate (normal structured region)\n")
cat("  3-5 Å   = Flexible (surface loops)\n")
cat("  > 5 Å   = Very flexible (disordered/highly mobile)\n\n")

cat("Higher fluctuation = MORE flexible/mobile\n")
cat("Lower fluctuation = MORE rigid/stable\n\n")

cat("Part1 (", part1, ") - Average Fluctuation:\n")
cat("  WT:  ", sprintf("%.2f", avg_part1_wt), "Å\n")
cat("  Δex2:", sprintf("%.2f", avg_part1_dex2), "Å\n")
cat("  Δ (Δex2 - WT):", sprintf("%+.2f", avg_part1_dex2 - avg_part1_wt), "Å\n")
cat("  % change:", sprintf("%+.1f%%", 100 * (avg_part1_dex2 - avg_part1_wt) / avg_part1_wt), "\n")

if (avg_part1_dex2 > avg_part1_wt * 1.1) {
  cat("  → Δex2 Part1 is MORE FLEXIBLE ✓\n")
} else if (avg_part1_dex2 < avg_part1_wt * 0.9) {
  cat("  → Δex2 Part1 is MORE RIGID\n")
} else {
  cat("  → Similar flexibility\n")
}
cat("\n")

cat("Part2 (", part2, ") - Average Fluctuation:\n")
cat("  WT:  ", sprintf("%.2f", avg_part2_wt), "Å\n")
cat("  Δex2:", sprintf("%.2f", avg_part2_dex2), "Å\n")
cat("  Δ (Δex2 - WT):", sprintf("%+.2f", avg_part2_dex2 - avg_part2_wt), "Å\n")
cat("  % change:", sprintf("%+.1f%%", 100 * (avg_part2_dex2 - avg_part2_wt) / avg_part2_wt), "\n")

if (avg_part2_dex2 > avg_part2_wt * 1.1) {
  cat("  → Δex2 Part2 is MORE FLEXIBLE ✓\n")
} else if (avg_part2_dex2 < avg_part2_wt * 0.9) {
  cat("  → Δex2 Part2 is MORE RIGID\n")
} else {
  cat("  → Similar flexibility\n")
}
cat("\n")

cat("Combined Epitope - Average Fluctuation:\n")
cat("  WT:  ", sprintf("%.2f", avg_combined_wt), "Å\n")
cat("  Δex2:", sprintf("%.2f", avg_combined_dex2), "Å\n")
cat("  Δ (Δex2 - WT):", sprintf("%+.2f", avg_combined_dex2 - avg_combined_wt), "Å\n")
cat("  % change:", sprintf("%+.1f%%", 100 * (avg_combined_dex2 - avg_combined_wt) / avg_combined_wt), "\n\n")

# Interpretation
cat("======================================================================\n")
cat("INTERPRETATION\n")
cat("======================================================================\n\n")

if (avg_combined_dex2 > avg_combined_wt * 1.2) {
  cat("✓ FLEXIBILITY HYPOTHESIS SUPPORTED!\n\n")
  cat("Δex2 epitope is significantly MORE FLEXIBLE.\n")
  cat("Loss of exon 2 removes structural support.\n")
  cat("Floppy epitope cannot maintain binding conformation.\n")
} else if (avg_combined_dex2 < avg_combined_wt * 0.9) {
  cat("✗ UNEXPECTED: Δex2 is MORE RIGID\n\n")
  cat("This contradicts the flexibility hypothesis.\n")
  cat("Binding loss likely due to geometry/orientation changes.\n")
} else {
  cat("~ Similar flexibility between WT and Δex2\n\n")
  cat("Binding loss may be due to geometry/orientation rather than flexibility.\n")
}
cat("\n")

# Save results to CSV
cat("Saving detailed results to CSV...\n")
results_df <- data.frame(
  Region = character(),
  Variant = character(),
  Position = integer(),
  Residue = character(),
  Fluctuation_Angstrom = numeric()
)

# Part1 WT
for (i in seq_along(part1_fluct_wt)) {
  results_df <- rbind(results_df, data.frame(
    Region = "Part1",
    Variant = "WT",
    Position = part1_wt$start + i - 1,
    Residue = substr(part1, i, i),
    Fluctuation_Angstrom = part1_fluct_wt[i]
  ))
}

# Part1 Δex2
for (i in seq_along(part1_fluct_dex2)) {
  results_df <- rbind(results_df, data.frame(
    Region = "Part1",
    Variant = "Δex2",
    Position = part1_dex2$start + i - 1,
    Residue = substr(part1, i, i),
    Fluctuation_Angstrom = part1_fluct_dex2[i]
  ))
}

# Part2 WT
for (i in seq_along(part2_fluct_wt)) {
  results_df <- rbind(results_df, data.frame(
    Region = "Part2",
    Variant = "WT",
    Position = part2_wt$start + i - 1,
    Residue = substr(part2, i, i),
    Fluctuation_Angstrom = part2_fluct_wt[i]
  ))
}

# Part2 Δex2
for (i in seq_along(part2_fluct_dex2)) {
  results_df <- rbind(results_df, data.frame(
    Region = "Part2",
    Variant = "Δex2",
    Position = part2_dex2$start + i - 1,
    Residue = substr(part2, i, i),
    Fluctuation_Angstrom = part2_fluct_dex2[i]
  ))
}

write.csv(results_df, "cartcontent/results/CD19 delta exon 2 analysis/05_nma_bio3d_results.csv", row.names = FALSE)
cat("✓ Results saved to: nma_bio3d_results.csv\n\n")

# Create visualizations
cat("Creating visualizations...\n")

# Summary data for bar chart
summary_df <- data.frame(
  Region = rep(c("Part1", "Part2", "Combined"), each = 2),
  Variant = rep(c("WT", "Δex2"), 3),
  Fluctuation = c(avg_part1_wt, avg_part1_dex2, 
                  avg_part2_wt, avg_part2_dex2, 
                  avg_combined_wt, avg_combined_dex2)
)

# Plot 1: Bar chart comparison
p1 <- ggplot(summary_df, aes(x = Region, y = Fluctuation, fill = Variant)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(values = c("WT" = "#2E7D32", "Δex2" = "#C62828")) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "green", alpha = 0.5) +
  geom_hline(yintercept = 3, linetype = "dashed", color = "orange", alpha = 0.5) +
  geom_hline(yintercept = 5, linetype = "dashed", color = "red", alpha = 0.5) +
  labs(x = "Epitope Region",
       y = "Average Fluctuation (Å)",
       title = "Epitope Flexibility Comparison (NMA)",
       subtitle = "Higher values = more flexible") +
  theme_minimal() +
  theme(legend.position = "top", text = element_text(size = 12))

# ggsave("/mnt/user-data/outputs/nma_bio3d_barplot.pdf", p1, width = 8, height = 6)

# Plot 2: Per-residue Part1
part1_detail_df <- data.frame(
  Position = c(part1_wt$start:part1_wt$end, part1_dex2$start:part1_dex2$end),
  Variant = rep(c("WT", "Δex2"), c(length(part1_fluct_wt), length(part1_fluct_dex2))),
  Fluctuation = c(part1_fluct_wt, part1_fluct_dex2)
)

p2 <- ggplot(part1_detail_df, aes(x = Position, y = Fluctuation, color = Variant, group = Variant)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  scale_color_manual(values = c("WT" = "#2E7D32", "Δex2" = "#C62828")) +
  labs(x = "Residue Position",
       y = "Fluctuation (Å)",
       title = paste0("Part1 (", part1, ") - Per-Residue Flexibility")) +
  theme_minimal() +
  theme(legend.position = "top")

# ggsave("/mnt/user-data/outputs/nma_bio3d_part1.pdf", p2, width = 10, height = 5)

# Plot 3: Per-residue Part2
part2_detail_df <- data.frame(
  Position = c(part2_wt$start:part2_wt$end, part2_dex2$start:part2_dex2$end),
  Variant = rep(c("WT", "Δex2"), c(length(part2_fluct_wt), length(part2_fluct_dex2))),
  Fluctuation = c(part2_fluct_wt, part2_fluct_dex2)
)

p3 <- ggplot(part2_detail_df, aes(x = Position, y = Fluctuation, color = Variant, group = Variant)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  scale_color_manual(values = c("WT" = "#2E7D32", "Δex2" = "#C62828")) +
  labs(x = "Residue Position",
       y = "Fluctuation (Å)",
       title = paste0("Part2 (", part2, ") - Per-Residue Flexibility")) +
  theme_minimal() +
  theme(legend.position = "top")

# ggsave("/mnt/user-data/outputs/nma_bio3d_part2.pdf", p3, width = 10, height = 5)

# cat("✓ Plots saved:\n")
# cat("  - /mnt/user-data/outputs/nma_bio3d_barplot.pdf\n")
# cat("  - /mnt/user-data/outputs/nma_bio3d_part1.pdf\n")
# cat("  - /mnt/user-data/outputs/nma_bio3d_part2.pdf\n\n")

cat("======================================================================\n")
cat("ANALYSIS COMPLETE\n")
cat("======================================================================\n")