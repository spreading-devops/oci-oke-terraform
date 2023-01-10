terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "4.102.0"
    }
  }
}

provider "oci" {
  region = var.region
}

