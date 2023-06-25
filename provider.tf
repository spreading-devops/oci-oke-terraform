terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "4.102.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "4.53.0"
    }
  }
}

provider "oci" {
  region = var.region
}

provider "aws" {
  region = var.aws_region
}
