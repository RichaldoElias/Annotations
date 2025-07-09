# Data Engineering Refresher

> ``Data engineering`` is the development, implementation, and maintenance of systems and processes that take in raw data and produce high-quality, consistent information that supports downstream use cases, such as analysis and machine learning.
    >> A data engineer manages the data engineering lifecycle, beginning with getting data from source systems and ending with serving data for use cases, such as analysis or machine learning.



## DataOps
> A set of practices an dcultural habits centered aroud building robust data systems and delivering high quality data products.
    >> Data product - a reusable, self-contained package that combines data, metadata, semantics, and templates to support various business needs. It's essentially a well-defined, accessible, and usable piece of data that's treated as a product, with a focus on its quality, discoverability, and usability for different purposes (DAMA-DMBOK).

DataOps is composed by tree pillars, namely:

* Automation
* Observability and Monitoring
* Incident Response (Cultural habits)


### DataOps - Automation [Infrastructure as Code]: Terraform

> The sintax of a terraform Configuration file is relatively simple, uses a Domain-Specific Langauge localled HCL (HashCorp Configuration Language) and follow the following standard:
>> resource ``keyword`` "aws_s3_bucket" ``Resource Type`` "data_lake" ``Name of the resource``


```terraform
resource "aws_s3_bucket" "data_lake" {
    bucket_prefix = "${var.project}-datalake"
}

resource "aws_s3_bucket_public_access_block" "data_lake" {
    bucket = aws_s3_bucket.data_lake.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

```

#### How to use Terraform

> Terraform lets you safely and consistently manage your infrastructure as code across multiple cloud providers. To provision infrastructure with Terraform, you will write configuration in Terraform's configuration language, configure your cloud provider credentials, and apply your configuration with the Terraform Command Line Interface (CLI). - [Terraform docs](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

First, install the HashiCorp tap, which is Hashicorp's official repository of all ``Homebrew`` packages.

```bash
brew tap hashicorp/tap
```
ter
Now, install Terraform from ``hashicorp/tap/terraform``.
```bash
brew install hashicorp/tap/terraform
```

To verify the installation:<br>
Verify that the installation worked by opening a new terminal session and listing Terraform's available subcommands.

```bash
terraform -help
```

#### Terraform main concepts

>terraform settings
```terraform
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 4.16"
        }
    }

    required_version = ">= 1.2.0"
}
```
> providers
>> A provider is a plugin file or a binary file that Terraform will use to create your resources.
```terraform
provider "aws" {
    region = "us=east-1"
}
```

> resources - let us create an EC2 instance

```terraform
resource "aws_instance" "webserver" {
    ami = "ami-***********"
    instance_type = "t2.micro"

    tags = {
        Name = "Websearver"
    }
}

```

After defining the desired resource, we can tell terraform to create the desired state of our infra <br>
The command below, Initialize the backend, providers defined in the configuration file
```bash
terraform init
```
<br>

After success initialization of terraform, we can use ``terraform plan`` and it will give us an execution plan that details what terraform is planning to create, update or destroy based on the configuration files.
<br>

After review, we can execute ``terraform apply`` that will ask for last approval, after it, we wait for the implementation of the execution plan. more examples of terraform, go to the labs folder.

### DataOps - Observability: Great Expectation

> When working with Great Expectations, you typically start your workflo by specifying the data that you wish to test, then you define the expectations or the tests that you want to perform on data, and finally, you validate your data against your expectations.
    >> 1. Specify the data
    >> 2. Define your expectations
    >> 3. Validate your data against the expectations

To make this possible, you need to interact with the Core components of Great Expectations, that are:

    Data Context -> Data Sources -> Expectations -> Checkpoints

These components are used to access, store, and manage the objects and processes that are needed in your workflow. 
<br>

Data Context
<br>

    The Entry point for the great expectations API (Instantiate a data context object)
    - Great Expectations API are classes and methods that allow you to connect data sources, create expectations and validate your data.
<br>

Data Source
<br>

    Tells great expectations from where to get the data that you want to validate.
    - Data Source: SQL Database, a local file system, an S3 bucket, a Pandas DataFrame...

    After connecting to a Data Source, you need to tell great expectations which part of the data you need to focus on, this is done by declaring a Data Asset (Collection of records within a data source - Table, Join query, File) that you'll scan in Batches (partitions from your data assets) using a Batch Request:

    Batch_request are the primary way to retrieve data from the data asset, and its what you provide for the rest of Great Expectations components. 
<br>

Expectations
<br>

    Statement that you use to verity if your data meets a certain condition (e.g: check if a column doesn't contain nulls). You can define your expectations or use one of the available statements from the expectation gallery (e.g: expect_column_values_to_be_unique).

    You can define more than one expectation for your data asset and collect them in an EXPECTATION SUITE object

<br>

Checkpoints
<br>

    To validate your data, you need to create a validator object which expects a batch request and its correcponding expectation suite. 
    - You can manually validate your data or automate the process using a checkpoint object that generate the validation results.

Throughout this process, metadata about your project will be generated and great expectation will save it in some backend stores.
> For practice, check the practical implementation on the labs folder.

