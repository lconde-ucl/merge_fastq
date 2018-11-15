# merge_fastq: Configuration for other clusters

It is entirely possible to run this pipeline on other clusters, though you will need to set up your own config file so that the pipeline knows how to work with your cluster.

> If you think that there are other people using the pipeline who would benefit from your configuration (eg. other common cluster setups), please let us know. We can add a new configuration and profile which can used by specifying `-profile <name>` when running the pipeline.

If you are the only person to be running this pipeline, you can create your config file as `~/.nextflow/config` and it will be applied every time you run Nextflow. Alternatively, save the file anywhere and reference it when running the pipeline with `-c path/to/config` (see the [Nextflow documentation](https://www.nextflow.io/docs/latest/config.html) for more).

A basic configuration comes with the pipeline (the `standard` config profile - see [`conf/base.config`](../conf/base.config)). This means that you only need to configure the specifics for your system and overwrite any defaults that you want to change.
Please note that THIS CONFIGURATION DOES NOT RUN BY DEFAULT, instead the 'legion' configuration is run by default.

## Cluster Environment
By default, pipeline uses the `sge` Nextflow executor - in other words, all jobs are sent to the queue and not run in the login session. 

To specify your cluster environment, add the following line to your config file:

```nextflow
process.executor = 'YOUR_SYSTEM_TYPE'
```

Many different cluster types are supported by Nextflow. For more information, please see the [Nextflow documentation](https://www.nextflow.io/docs/latest/executor.html).

Note that you may need to specify cluster options, such as a project or queue. To do so, use the `clusterOptions` config option:

```nextflow
process {
  executor = 'SLURM'
  clusterOptions = '-A myproject'
}
```


## Software Requirements
None
