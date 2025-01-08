#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process ExtractHDF5 {
    input:
    path hdf5_file

    output:
    path "extracted_data/*.csv"

    script:
    """
    Rscript scripts/extract_hdf5.R $hdf5_file extracted_data/
    """
}

process QualityControl {
    input:
    path data_files

    output:
    path "qc_results/*.csv"

    script:
    """
    Rscript scripts/quality_control.R $data_files qc_results/
    """
}

process NormalizeData {
    input:
    path qc_files

    output:
    path "normalized_data/*.csv"

    script:
    """
    Rscript scripts/normalization.R $qc_files normalized_data/
    """
}

// Add additional processes for clustering, DGE, and pathway analysis

workflow {
    Channel
        .fromPath("data/*.h5")
        .set { hdf5_files }

    hdf5_files | ExtractHDF5 | QualityControl | NormalizeData
}
