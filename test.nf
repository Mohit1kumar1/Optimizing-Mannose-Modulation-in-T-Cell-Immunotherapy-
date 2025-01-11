#!/usr/bin/env nextflow

process Hello {
    script:
    """
    echo "Hello, World!"
    """
}
workflow {
    Hello()
}