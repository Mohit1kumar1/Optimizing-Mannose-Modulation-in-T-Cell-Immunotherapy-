#!/usr/bin/env Rscript

library(Matrix)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Load filtered matrix
matrix <- Matrix::readMM(file.path(input_dir, "filtered_matrix.mtx"))

# Normalize (log-transform)
normalized_matrix <- log1p(matrix / Matrix::colSums(matrix) * 1e6)

# Save normalized data
Matrix::writeMM(normalized_matrix, file.path(output_dir, "normalized_matrix.mtx"))

message("Normalization completed.")
