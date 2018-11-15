#!/usr/bin/env nextflow
/*
========================================================================================
                         nf-core/merge_fastq
========================================================================================
 nf-core/merge_fastq Analysis Pipeline.
 #### Homepage / Documentation
 https://github.com/nf-core/merge_fastq
----------------------------------------------------------------------------------------
*/


def helpMessage() {
    log.info"""
    =========================================
     nf-core/merge_fastq v${workflow.manifest.version}
    =========================================
    Usage:

    The typical command for running the pipeline is as follows:

    nextflow run nf-core/merge_fastq --inputdir fastq_files --outputdir merged_fastq_files

    Optional arguments:
      --inputdir                    Path to input data [fastq_files]
      --outdir                      The output directory where the results will be saved [merged_fastq_files]
    """.stripIndent()
}

/*
 * Defines reads and outputdir
 */
params.inputdir = "fastq_files"
params.outdir = 'merged_fastq_files'
input = file(params.inputdir)

/* 
 * header 
 */

println "=========================================="
println "M E R G E_F A S T Q    P I P E L I N E    "
println "=========================================="
println "inputdir           : ${params.inputdir}"
println "outdir             : ${params.outdir}"

/*
 * Show help when needed
 */
if (params.help){
    log.info helpMessage
    exit 0
}
 
/*
 * Merge FastQ files
 */

process merge_fastq {

    publishDir params.outdir, mode: 'copy'  

    input:
    file inputdir from input

    output:
    file merge_log
    file '*.gz'

    script:
    """
    merge_and_rename_NGI_fastq_files.py $inputdir ./ > merge_log
    """
}

workflow.onComplete { 
	println ( workflow.success ? "Merging done! transferring merged files and wrapping up..." : "Oops .. something went wrong" )
}

