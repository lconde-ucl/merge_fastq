# merge_fastq: Usage

## Table of contents

* [Running the pipeline](#running-the-pipeline)
* [Main arguments](#main-arguments)
    * [`-profile`](#-profile-single-dash)
        * [`legion`](#legion)
        * [`standard`](#standard)
        * [`none`](#none)
    * [`--inputdir`](#--inputdir)
* [Job Resources](#job-resources)
* [Automatic resubmission](#automatic-resubmission)
* [Custom resource requests](#custom-resource-requests)
* [Other command line parameters](#other-command-line-parameters)
    * [`--outdir`](#--outdir)
    * [`-resume`](#-resume-single-dash)
    * [`--max_memory`](#--max_memory)
    * [`--max_time`](#--max_time)
    * [`--max_cpus`](#--max_cpus)


## Running the pipeline
The typical command for running the pipeline  with the "nextflow_mergefastq' alias is as follows:
```bash
module load blic-modules
module load nextflow_mergefastq

nextflow_mergefastq --inputdir fastq_files --outputdir merged_fastq_files 
```

This will launch the pipeline with the `legion` or `myriad` configuration profile, depending on where you submit the job from.

Note that the pipeline will create the following files in your working directory:

```bash
work                     # Directory containing the nextflow working files
merged_fastq_files       # Finished results (configurable, see below)
.nextflow_log            # Log file from Nextflow
# Other nextflow hidden files, eg. history of pipeline runs and old logs.
```

## Main Arguments

To see all the available arguments, use the `--help` flag
```bash
nextflow_wgsalign --help
```

The main arguments are:

### `-profile`
This parameter is NOT necessary as the shortcut `nextflow_merge_fastq` takes care of selecting the appropiate configuration profile. But just for your information, profiles are used to give 
configuration presets for different compute environments.

* `legion`
    * A generic configuration profile to be used with the UCL cluster legion
* `myriad`
    * A generic configuration profile to be used with the UCL cluster myriad

### `--inputdir`
Use this to specify the location of your input FastQ files. For example:

```bash
--inputdir 'path/to/data/fastq_files/'
```

If left unspecified, it will look for the default dir: './fastq_files'

## Job Resources
### Automatic resubmission
Each step in the pipeline has a default set of requirements for number of CPUs, memory and time. For most of the steps in the pipeline, if the job exits with an error code of `143` (exceeded requested resources) it will automatically resubmit with higher requests (2 x original, then 3 x original). If it still fails after three times then the pipeline is stopped.

## Other command line parameters

### `--outdir`
The output directory where the results will be saved. If left unespecified, it will use the default dir: 'merged_fastq_files'

### `-resume`
Specify this when restarting a pipeline. Nextflow will used cached results from any pipeline steps where the inputs are the same, continuing from where it got to previously.
Please note that since this pipeline only runs one process, the -resume option is not useful here. This might change if more processes are added to the pipeline in the future.

You can also supply a run name to resume a specific run: `-resume [run-name]`. Use the `nextflow log` command to show previous run names.

**NB:** Single hyphen (core Nextflow option)

### `--max_memory`
Use to set a top-limit for the default memory requirement for each process.
Should be a string in the format integer-unit. eg. `--max_memory '8.GB'``

### `--max_time`
Use to set a top-limit for the default time requirement for each process.
Should be a string in the format integer-unit. eg. `--max_time '2.h'`

### `--max_cpus`
Use to set a top-limit for the default CPU requirement for each process.
Should be a string in the format integer-unit. eg. `--max_cpus 1`

