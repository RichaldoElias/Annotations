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


