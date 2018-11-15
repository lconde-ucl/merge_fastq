# nf-core/merge_fastq: Installation

To start using the nf-core/merge_fastq pipeline, follow the steps below:

1. [Install Nextflow](#1-install-nextflow)
2. [Install the pipeline](#2-install-the-pipeline)
    * [Automatic](#21-automatic)
    * [Offline](#22-offline)
    * [Development](#23-development)
3. [Pipeline configuration](#3-pipeline-configuration)
    * [Configuration profiles](#33-configuration-profiles)
4. [Reference genomes](#4-reference-genomes)
5. [Appendices](#appendices)
    * [Running on UPPMAX](#running-on-uppmax)

## 1) Install NextFlow
Nextflow runs on most POSIX systems (Linux, Mac OSX etc). It can be installed by running the following commands:

```bash
# Make sure that Java v8+ is installed:
java -version

# Install Nextflow
curl -fsSL get.nextflow.io | bash

# Add Nextflow binary to your PATH:
mv nextflow ~/bin/
# OR system-wide installation:
# sudo mv nextflow /usr/local/bin
```

See [nextflow.io](https://www.nextflow.io/) for further instructions on how to install and configure Nextflow.

## 2) Install the pipeline

#### 2.1) Automatic
This pipeline itself needs no installation - NextFlow will automatically fetch it from GitHub if `nf-core/merge_fastq` is specified as the pipeline name.

#### 2.2) Offline
The above method requires an internet connection so that Nextflow can download the pipeline files. If you're running on a system that has no internet connection, you'll need to download and transfer the pipeline files manually:

```bash
wget https://github.com/nf-core/merge_fastq/archive/master.zip
mkdir -p ~/my-pipelines/nf-core/
unzip master.zip -d ~/my-pipelines/nf-core/
cd ~/my_data/
nextflow run ~/my-pipelines/nf-core/merge_fastq-master
```

To stop nextflow from looking for updates online, you can tell it to run in offline mode by specifying the following environment variable in your ~/.bashrc file:

```bash
export NXF_OFFLINE='TRUE'
```

#### 2.3) Development

If you would like to make changes to the pipeline, it's best to make a fork on GitHub and then clone the files. Once cloned you can run the pipeline directly as above.


## 3) Pipeline configuration
By default, the pipeline runs with the `standard` configuration profile. This uses a number of sensible defaults for process requirements and is suitable for running on a simple (if powerful!) basic server. You can see this configuration in [`conf/base.config`](../conf/base.config).

Be warned of two important points about this default configuration:

1. The default profile uses the `local` executor
    * All jobs are run in the login session. If you're using a simple server, this may be fine. If you're using a compute cluster, this is bad as all jobs will run on the head node.
    * See the [nextflow docs](https://www.nextflow.io/docs/latest/executor.html) for information about running with other hardware backends. Most job scheduler systems are natively supported.
2. Nextflow will expect all software to be installed and available on the `PATH`

