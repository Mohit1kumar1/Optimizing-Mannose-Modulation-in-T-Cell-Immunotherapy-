#!/usr/bin/env Rscript

library(rhdf5)

args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_dir <- args[2]

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

h5ls(input_file)

# Extract barcodes
barcodes <- h5read(input_file, "/matrix/barcodes")
write.csv(barcodes, file = file.path(output_dir, "barcodes.csv"), row.names = FALSE)

# Extract features
features <- h5read(input_file, "/matrix/features/id")
write.csv(features, file = file.path(output_dir, "features.csv"), row.names = FALSE)

# Extract matrix data
data <- h5read(input_file, "/matrix/data")
indices <- h5read(input_file, "/matrix/indices")
indptr <- h5read(input_file, "/matrix/indptr")
shape <- h5read(input_file, "/matrix/shape")

# Save matrix data as a sparse matrix
sparse_matrix <- Matrix::sparseMatrix(
  i = indices + 1, 
  p = indptr, 
  x = data, 
  dims = shape
)
Matrix::writeMM(sparse_matrix, file.path(output_dir, "matrix.mtx"))

message("HDF5 data extraction completed.")
