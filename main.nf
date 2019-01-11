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
    =======================================================
                                              ,--./,-.
              ___     __   __   __   ___     /,-._.--~\'
        |\\ | |__  __ /  ` /  \\ |__) |__         }  {
        | \\| |       \\__, \\__/ |  \\ |___     \\`-._,-`-,
                                              `._,._,\'
     nf-core/merge_fastq v${workflow.manifest.version}
    =======================================================
    Usage:

    The typical command for running the pipeline is as follows:

    nextflow run nf-core/merge_fastq --inputdir fastq_files --outputdir merged_fastq_files

    Optional arguments:
      --inputdir                    Path to input data [fastq_files]
      --outdir                      The output directory where the results will be saved [merged_fastq_files]
    """.stripIndent()
}

// Show help emssage
params.help = false
if (params.help){
    helpMessage()
    exit 0
}


// Defines reads and outputdir
params.inputdir = "fastq_files"
params.outdir = 'merged_fastq_files'
input = file(params.inputdir)


// Header 
println "========================================================"
println "                                       ,--./,-.         "
println "          ___     __  __   __  ___    /,-._.--~\'       "
println "    |\\ | |__  __ /  `/  \\ |__)|__        }  {         "
println "    | \\| |       \\__ \\__/ |  \\|___   \\`-._,-`-,    "
println "                                      `._,._,\'         "
println "                                                        "
println "       M E R G E _ F A S T Q    P I P E L I N E         "
println "========================================================"
println "['Pipeline Name']     = nf-core/merge_fastq"
println "['Pipeline Version']  = workflow.manifest.version"
println "['Inputdir']          = $params.inputdir"
println "['Output dir']        = $params.outdir"
println "['Working dir']       = workflow.workDir"
println "['Container Engine']  = workflow.containerEngine"
println "['Current home']      = $HOME"
println "['Current user']      = $USER"
println "['Current path']      = $PWD"
println "['Working dir']       = workflow.workDir"
println "['Script dir']        = workflow.projectDir"
println "['Config Profile']    = workflow.profile"
println "========================================================"

 
// Merge FastQ files

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
    log.info "[nf-core/test] Pipeline Complete"

}

