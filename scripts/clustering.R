#!/usr/bin/env Rscript

library(Matrix)
library(stats)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Load normalized matrix
normalized_matrix <- Matrix::readMM(file.path(input_dir, "normalized_matrix.mtx"))

# Perform PCA
pca_results <- prcomp(as.matrix(normalized_matrix), scale. = TRUE)

# Perform K-means clustering
kmeans_results <- kmeans(pca_results$x, centers = 3) # Adjust the number of clusters as needed

# Save clustering results
write.csv(kmeans_results$cluster, file = file.path(output_dir, "clusters.csv"), row.names = TRUE)
write.csv(pca_results$x, file = file.path(output_dir, "pca_coordinates.csv"), row.names = TRUE)

message("Clustering completed.")
