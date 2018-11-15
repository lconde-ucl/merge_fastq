# merge_fastq: Installation

The merge_fastq pipeline is already installed in legion. You just need to load nextflow and start using it:

```bash
module load blic-modules
module load nextflow

nextflow_mergefastq --inputdir DIR --outputdir DIR
```

By default, the pipeline runs with the `legion` configuration profile. You cna change this and run it with the 'standard' profile which will make it run in local mode. This uses a number of sensible defaults for process 
requirements and is suitable for running on a simple (if powerful!) basic server. You can see this configuration in [`conf/base.config`](../conf/base.config).

Be warned of two important points about the 'standard' configuration:

1. It uses the `local` executor
    * All jobs are run in the login session. If you're using a simple server, this may be fine. If you're using a compute cluster, this is bad as all jobs will run on the head node.
    * See the [nextflow docs](https://www.nextflow.io/docs/latest/executor.html) for information about running with other hardware backends. Most job scheduler systems are natively supported.
2. Nextflow will expect all software to be installed and available on the `PATH`

