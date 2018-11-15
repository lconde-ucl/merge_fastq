# nf-core/merge_fastq: Output

This document describes the output produced by the pipeline. Most of the plots are taken from the MultiQC report, which summarises results at the end of the pipeline.


## Pipeline overview
The pipeline is built using [Nextflow](https://www.nextflow.io/)
and processes data using the following steps:

* [merge_fastq](#merge_fastq) - Merge FastQ files

## merge_fastq
[F](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) gives general quality metrics about your reads. It provides information about the quality score distribution across your reads, the per base sequence content (%T/A/G/C). You get information about adapter contamination and other overrepresented sequences.

For further reading and documentation see the [FastQC help](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/).

**Output directory: `merged_fastq_files/`**

* `merge_log`
  * Text report showing which original FastQ files were merged together
* `*fastq.gz`
  * FastQ files after merging lanes for each sample

