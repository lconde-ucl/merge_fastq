# merge_fastq: Usage

## Table of contents

* [Introduction](#general-nextflow-info)
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


## General Nextflow info
Nextflow handles job submissions on SLURM or other environments, and supervises running the jobs. Thus the Nextflow process must run until the pipeline is finished. We recommend that you put the process running in the background through `screen` / `tmux` or similar tool. Alternatively you can run nextflow within a cluster job submitted your job scheduler.

It is recommended to limit the Nextflow Java virtual machines memory. We recommend adding the following line to your environment (typically in `~/.bashrc` or `~./bash_profile`):

```bash
NXF_OPTS='-Xms1g -Xmx4g'
```

## Running the pipeline
The typical command for running the pipeline  with the "nextflow_mergefastq' alias is as follows:
```bash
module load blic-modules
module load nextflow

nextflow_mergefastq --inputdir fastq_files --outputdir merged_fastq_files 
```

This will launch the pipeline with the `legion` configuration profile. See below for more information about profiles.

If you wnat to run the pipeline using a different profile, then you need to specify the full command instead of the shortcut:
```bash
module load blic-modules
module load nextflow

nextflow run /shared/ucl/depts/cancer/apps/nextflow_pipelines/merge_fastq-master -profile legion --inputdir fastq_files --outputdir merged_fastq_files 
```

Note that the pipeline will create the following files in your working directory:

```bash
work                     # Directory containing the nextflow working files
merged_fastq_files       # Finished results (configurable, see below)
.nextflow_log            # Log file from Nextflow
# Other nextflow hidden files, eg. history of pipeline runs and old logs.
```

## Main Arguments

### `-profile`
Use this parameter to choose a configuration profile. Profiles can give configuration presets for different compute environments.

* `standard`
    * The default profile, used if `-profile` is not specified at all.
    * Runs locally and expects all software to be installed and available on the `PATH`.
* `legion`
    * A generic configuration profile to be used with the UCL cluster legion.
* `none`
    * No configuration at all. Useful if you want to build your own config from scratch and want to avoid loading in the default `base` config profile (not recommended).

### `--inputdir`
Use this to specify the location of your input FastQ files. For example:

```bash
--inputdir 'path/to/data/fastq_files/'
```

If left unspecified, it will look for the default dir: './fastq_files'


## Job Resources
### Automatic resubmission
Each step in the pipeline has a default set of requirements for number of CPUs, memory and time. For most of the steps in the pipeline, if the job exits with an error code of `143` (exceeded requested resources) it will automatically resubmit with higher requests (2 x original, then 3 x original). If it still fails after three times then the pipeline is stopped.

### Custom resource requests
Wherever process-specific requirements are set in the pipeline, the default value can be changed by creating a custom config file. See the files in [`conf`](../conf) for examples.

## Other command line parameters

### `--outdir`
The output directory where the results will be saved. If left unespecified, it will use the default dir: 'merged_fastq_files'

### `-resume`
Specify this when restarting a pipeline. Nextflow will used cached results from any pipeline steps where the inputs are the same, continuing from where it got to previously.
Please note that since this pipeline only runs one process, the -resume option is not useful here. This might change if more processes are added to the pipeline in the future.

You can also supply a run name to resume a specific run: `-resume [run-name]`. Use the `nextflow log` command to show previous run names.

**NB:** Single hyphen (core Nextflow option)

### `-c`
Specify the path to a specific config file (this is a core NextFlow command).

**NB:** Single hyphen (core Nextflow option)

Note - you can use this to override defaults.

### `--max_memory`
Use to set a top-limit for the default memory requirement for each process.
Should be a string in the format integer-unit. eg. `--max_memory '8.GB'``

### `--max_time`
Use to set a top-limit for the default time requirement for each process.
Should be a string in the format integer-unit. eg. `--max_time '2.h'`

### `--max_cpus`
Use to set a top-limit for the default CPU requirement for each process.
Should be a string in the format integer-unit. eg. `--max_cpus 1`

