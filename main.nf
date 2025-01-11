#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process ExtractHDF5 {
    input:
    path hdf5_file

    output:
    path "extracted_data/*.csv"

    script:
    """
    Rscript C:/Users/mh319/Desktop/VS Code/Github Repo/T Cell Workflow/scripts/extract_hdf5.R $hdf5_file extracted_data/
    """
}

process QualityControl {
    input:
    path data_files

    output:
    path "qc_results/*.csv"

    script:
    """
    Rscript C:/Users/mh319/Desktop/VS Code/Github Repo/T Cell Workflow/scripts/quality_control.R $data_files qc_results/
    """
}

process NormalizeData {
    input:
    path qc_files

    output:
    path "normalized_data/*.csv"

    script:
    """
    Rscript C:/Users/mh319/Desktop/VS Code/Github Repo/T Cell Workflow/scripts/normalization.R $qc_files normalized_data/
    """
}

process Clustering {
    input:
    path normalized_files

    output:
    path "clustering_results/*.csv"

    script:
    """
    Rscript C:/Users/mh319/Desktop/VS Code/Github Repo/T Cell Workflow/scripts/clustering.R $normalized_files clustering_results/
    """
}

process DifferentialExpression {
    input:
    path normalized_files

    output:
    path "dge_results/*.csv"

    script:
    """
    Rscript C:/Users/mh319/Desktop/VS Code/Github Repo/T Cell Workflow/scripts/dge.R $normalized_files dge_results/
    """
}

process PathwayAnalysis {
    input:
    path dge_files

    output:
    path "pathway_analysis_results/*.csv"

    script:
    """
    Rscript C:/Users/mh319/Desktop/VS Code/Github Repo/T Cell Workflow/scripts/pathway_analysis.R $dge_files pathway_analysis_results/
    """
}

workflow {
    Channel
        .fromPath("data/*.h5")
        .set { hdf5_files }

    hdf5_files | 
        ExtractHDF5 | 
        QualityControl | 
        NormalizeData |
        Clustering |
        DifferentialExpression |
        PathwayAnalysis
}
