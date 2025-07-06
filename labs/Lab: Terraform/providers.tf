# contains information about the providers used in this configuration

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 4.16"
        }
    }
    required_version = ">= 1.2.0"
}
# Providers
provider "aws" {
    region = var.region
}