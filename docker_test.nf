nextflow.enable.dsl=2

process TestDocker {
    container 'hello-world'
    script:
    """
    echo "Testing Docker with Nextflow"
    """
}

workflow {
    TestDocker()
}
