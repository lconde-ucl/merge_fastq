[![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.XXXXXXX-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.XXXXXXX)

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A521.10.3-23aa62.svg)](https://www.nextflow.io/)

## Introduction

**merge_fastq** is a Nextflow pipeline that merges FastQ files from different lanes

The pipeline is built using [Nextflow](https://www.nextflow.io), a workflow tool to run tasks across multiple compute infrastructures in a very portable manner.

## Pipeline summary

Given a list of FastQ files, it merges, for each sample, all the files from different lanes, so that at the end there is only one R1 and R2 file per sample

This pipeline is based on the [merge_and_rename_NGI_fastq_files.py](https://github.com/SciLifeLab/standalone_scripts/blob/master/merge_and_rename_NGI_fastq_files.py) standalone
script from SciLifeLab. FastQ files are expected to have the typical Illumina naming convention (Ex: SampleName_S1_L001_R1_001.fastq.gz) 
to make sure that lanes are merged correctly.

Specifically, filenames have to match the following regular expression: ^(.+)_S[0-9]+(_.+)*_R([1-2])_

```
Example:
	fastq_files/E3387-3t_S10_L001_R1_001.fastq.gz
	fastq_files/E3387-3t_S10_L003_R1_001.fastq.gz
	fastq_files/E3387-3t_S11_L001_R1_001.fastq.gz
	fastq_files/E3387-3t_S11_L002_R1_001.fastq.gz
	
	are merged as ./E3387-3t_R1.fastq.gz
```

## Quick Start

1. module load blic-modules

2. module load nf/merge_fastq

. Start running your own analysis!

   ```bash
   merge_fastq --inputdir <INPUTDIR> [--outdir <OUTDIR>]
   ```

## Credits

merge_fastq was developed by LC and built around [this script](https://github.com/SciLifeLab/standalone_scripts/blob/master/merge_and_rename_NGI_fastq_files.py) from SciLifeLab


## Citations

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/master/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).

