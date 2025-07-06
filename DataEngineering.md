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

After review, we can execute ``terraform apply`` that will ask for last approval, after it we wait for the implementation of the execution plan. more examples of terraform, go to the labs folder.
