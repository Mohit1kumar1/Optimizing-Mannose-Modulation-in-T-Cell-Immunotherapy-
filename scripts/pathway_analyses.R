#!/usr/bin/env Rscript

library(clusterProfiler)
library(org.Mm.eg.db)  # For mouse data, replace with org.Hs.eg.db for human

args <- commandArgs(trailingOnly = TRUE)
dge_file <- args[1]
output_dir <- args[2]

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Load DGE results
dge_results <- read.csv(dge_file)


# Select significant genes
significant_genes <- dge_results[dge_results$adj.P.Val < 0.05, "Gene"]

# Convert gene symbols to Entrez IDs
entrez_ids <- bitr(significant_genes, fromType = "SYMBOL", toType = "ENTREZID", OrgDb = org.Mm.eg.db)

# Perform KEGG pathway enrichment analysis
kegg_results <- enrichKEGG(gene = entrez_ids$ENTREZID, organism = "mmu")

# Save results
write.csv(as.data.frame(kegg_results), file = file.path(output_dir, "kegg_results.csv"))

message("Pathway analysis completed.")
