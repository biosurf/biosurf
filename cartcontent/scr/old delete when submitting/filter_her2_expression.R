#!/usr/bin/env Rscript

# filter_her2_expression.R
# Script to filter HER2 isoforms from TCGA/GTEx expression data

library(tidyverse)

cat("Starting HER2 expression filtering...\n")
cat("Time:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# File paths
expr_file <- "/home/projects/dtu_00062/people/giomor/cart_test/TcgaTargetGtex_rsem_isoform_tpm.gz"
filtered_file <- "/home/projects/dtu_00062/people/giomor/cart_test/her2_isoforms_filtered.txt"
output_rds <- "/home/projects/dtu_00062/people/giomor/cart_test/her2_expr_filtered.rds"

# HER2 transcripts to keep
her2_transcripts <- c(
  "ENST00000578709", "ENST00000584601", "ENST00000582818", "ENST00000584450",
  "ENST00000584014", "ENST00000580074", "ENST00000445658", "ENST00000578502",
  "ENST00000269571", "ENST00000578199", "ENST00000863098", "ENST00000863102",
  "ENST00000863097", "ENST00000863101", "ENST00000863100", "ENST00000863099",
  "ENST00000863095", "ENST00000863096", "ENST00000863103", "ENST00000959774",
  "ENST00000938923", "ENST00000938925", "ENST00000938924", "ENST00000959775"
)

cat("Looking for", length(her2_transcripts), "HER2 transcripts\n\n")

# STEP 1: Filter line-by-line
cat("STEP 1: Filtering expression file...\n")

con <- gzfile(expr_file, "r")

# Read and write header
header <- readLines(con, n = 1)
writeLines(header, filtered_file)

# Read line by line and filter
line_count <- 0
matched_count <- 0

while (TRUE) {
  lines <- readLines(con, n = 1000)
  
  if (length(lines) == 0) break
  
  line_count <- line_count + length(lines)
  
  # Filter for HER2 transcripts
  pattern <- paste0("^(", paste(her2_transcripts, collapse = "|"), ")(\\.|\\t)")
  matching_lines <- grep(pattern, lines, value = TRUE)
  
  if (length(matching_lines) > 0) {
    write(matching_lines, file = filtered_file, append = TRUE)
    matched_count <- matched_count + length(matching_lines)
  }
  
  # Progress update every million lines
  if (line_count %% 1000000 == 0) {
    cat("  Processed", format(line_count, big.mark = ","), "lines, found", 
        matched_count, "HER2 transcripts\n")
  }
}

close(con)

cat("\nFiltering complete!\n")
cat("  Total lines processed:", format(line_count, big.mark = ","), "\n")
cat("  HER2 transcripts found:", matched_count, "\n")
cat("  Filtered file:", filtered_file, "\n\n")

# STEP 2: Read filtered file and save as RDS
cat("STEP 2: Reading filtered data...\n")
her2_expr <- read_tsv(filtered_file, show_col_types = FALSE)

cat("  Dimensions:", nrow(her2_expr), "rows x", ncol(her2_expr), "columns\n")
cat("  Transcripts:\n")
print(her2_expr$sample)

# STEP 3: Save as RDS
cat("\nSTEP 3: Saving as RDS...\n")
saveRDS(her2_expr, output_rds)

# Check file size
file_size <- file.info(output_rds)$size / 1024^2  # MB
cat("  Output file:", output_rds, "\n")
cat("  File size:", round(file_size, 2), "MB\n")

cat("\nDone! Time:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")