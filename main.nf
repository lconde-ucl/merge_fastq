nextflow.enable.dsl = 2


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    VALIDATE & PRINT PARAMETER SUMMARY
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/


// Check inputdir exists

// This actually cannot happen as there is a default inputdir in nextflow.config
if( !params.inputdir ){
    exit 1, "No inputdir specified! Specify path with --inputdir."
}

inputdir = file(params.inputdir)
if( !inputdir.exists() ) exit 1, "Inputdir folder not found: ${params.inputdir}. Specify path with --inputdir."

fastqs_ch = Channel.fromPath( params.inputdir, checkIfExists: true)


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    MODULES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { MERGEFASTQ } from './modules/local/mergefastq'


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    HELP 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

def helpMessage() {
    log.info """
          Usage:
          The typical command for running the pipeline is as follows:
          merge_fastq --inputdir ./fastq_files [--outdir ./merged_fastq_files]

          Arguments:
           --inputdir                     Folder that contains the FastQ files [./fastq_files]
           --outdir                       Output director [./merged_fastq_files]
           --help                         This usage statement

          Other useful nextflow arguments:
           -resume                        Execute the script using the cached results, useful to continue executions that was stopped by an error [False]
           -with-tower                    Monitor workflow execution with Seqera Tower service [False]
           -ansi-log                      Enable/disable ANSI console logging [True]
           -N, -with-notification         Send a notification email on workflow completion to the specified recipients [False]

          ** Important **
          ** FastQ files are expected to have the typical Illumina naming convention (Ex: SampleName_S1_L001_R1_001.fastq.gz) to make sure that lanes are merged correctly **
          ** Specifically, filenames have to match the following regular expression: ^(.+)_S[0-9]+(_.+)*_R([1-2])_ **

          Example: 

           fastq_files/E3387-3t_S10_L001_R1_001.fastq.gz
           fastq_files/E3387-3t_S10_L003_R1_001.fastq.gz
           fastq_files/E3387-3t_S11_L001_R1_001.fastq.gz
           fastq_files/E3387-3t_S11_L002_R1_001.fastq.gz

           are merged as ./E3387-3t_R1.fastq.gz

           }
           """
}

if (params.help){
    helpMessage()
    exit 0
}


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    HEADER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/


// Header 
println "=============================================================="
println "    N E X T F L O W   M E R G E F A S T Q   P I P E L I N E   "
println "=============================================================="
println "['Pipeline Name']     = nf/merge_fastq"
println "['Pipeline Version']  = $workflow.manifest.version"
println "['Inputdir']          = $params.inputdir"
println "['Outdir']            = $params.outdir"
println "['Working dir']       = $workflow.workDir"
println "['Current user']      = $USER"
println "========================================================"



/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN ALL WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow{ 
    MERGEFASTQ(fastqs_ch) 
} 


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow.onComplete {                
    println "Pipeline completed at: $workflow.complete"
    println "Execution status: ${ workflow.success ? 'OK' : 'failed' }"
}


workflow.onError = {
    println "Oops... Pipeline execution stopped with the following message: ${workflow.errorMessage}"
}
