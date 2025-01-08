install.packages("rhdf5")
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rhdf5")

library(rhdf5)
h5ls("C:\\Users\\mh319\\Desktop\\VS Code\\Github Repo\\T Cell Workflow\\GSE254222_RAW\\GSM8036223_proc.dm.h5") # nolint
h5ls("C:\\Users\\mh319\\Desktop\\VS Code\\Github Repo\\T Cell Workflow\\GSE254222_RAW\\GSM8036224_proc.ctrl.h5") # nolint


