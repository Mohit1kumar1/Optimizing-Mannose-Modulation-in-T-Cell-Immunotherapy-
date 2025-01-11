#!/usr/bin/env Rscript

library(Matrix)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

barcodes <- read.csv(file.path(input_dir, "barcodes.csv"))
features <- read.csv(file.path(input_dir, "features.csv"))
matrix <- Matrix::readMM(file.path(input_dir, "matrix.mtx"))

# Perform QC (example thresholds)
valid_genes <- which(Matrix::rowSums(matrix) > 10)
valid_cells <- which(Matrix::colSums(matrix) > 200)

filtered_matrix <- matrix[valid_genes, valid_cells]
filtered_barcodes <- barcodes[valid_cells, ]
filtered_features <- features[valid_genes, ]

# Save QC results
write.csv(filtered_barcodes, file = file.path(output_dir, "filtered_barcodes.csv"), row.names = FALSE)
write.csv(filtered_features, file = file.path(output_dir, "filtered_features.csv"), row.names = FALSE)
Matrix::writeMM(filtered_matrix, file.path(output_dir, "filtered_matrix.mtx"))

message("Quality control completed.")
