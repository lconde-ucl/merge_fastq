# merge_fastq: Output

This document describes the output produced by the pipeline.


## Pipeline overview
The pipeline is built using [Nextflow](https://www.nextflow.io/)
and processes data using the following steps:

* [merge_fastq](#merge_fastq) - Merge FastQ files

## merge_fastq
This script is based on the [merge_and_rename_NGI_fastq_files.py](https://github.com/SciLifeLab/standalone_scripts) standalone script from SciLifeLab.
FastQ files are expected to have the typical Illumina naming convention (Ex: SampleName_S1_L001_R1_001.fastq.gz) to make sure that lanes are merged correctly.

Example: 
	fastq_files/E3387-1t_S9_L001_R1_001.fastq.gz
	fastq_files/E3387-1t_S9_L002_R1_001.fastq.gz
		are merged as E3387-1t_R1.fastq.gz

	fastq_files/E3387-3t_S10_L001_R1_001.fastq.gz
	fastq_files/E3387-3t_S10_L003_R1_001.fastq.gz
	fastq_files/E3387-3t_S11_L001_R1_001.fastq.gz
	fastq_files/E3387-3t_S11_L002_R1_001.fastq.gz
		are merged as ./E3387-3t_R1.fastq.gz

**Output directory: `merged_fastq_files/`**

* `merge_log`
  * Text report showing which original FastQ files were merged together
* `*fastq.gz`
  * FastQ files after merging lanes for each sample

