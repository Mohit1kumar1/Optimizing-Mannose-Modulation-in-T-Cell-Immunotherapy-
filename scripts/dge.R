#!/usr/bin/env Rscript

library(limma)

args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Load normalized matrix
normalized_matrix <- Matrix::readMM(file.path(input_dir, "normalized_matrix.mtx"))

# Simulated design matrix (update this for your specific conditions/groups)
group <- factor(rep(c("Control", "Treatment"), each = ncol(normalized_matrix) / 2))
design <- model.matrix(~group)

# Fit model
fit <- lmFit(as.matrix(normalized_matrix), design)
fit <- eBayes(fit)

# Extract top differentially expressed genes
top_genes <- topTable(fit, coef = 2, number = Inf)

# Save results
write.csv(top_genes, file = file.path(output_dir, "dge_results.csv"))


message("Differential gene expression analysis completed.")
