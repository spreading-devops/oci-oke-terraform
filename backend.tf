resource "aws_s3_bucket" "tfstate-oci" {
  bucket = "tfstate-oci.${var.domain}"
  tags = {
    Name        = "project"
    Environment = "${var.domain}"
  }
}

resource "aws_s3_bucket_acl" "tfstate-oci-acl" {
  bucket = aws_s3_bucket.tfstate-oci.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tfstate-oci-versioning" {
  bucket = aws_s3_bucket.tfstate-oci.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tfstate-oci" {
  name           = "tfstate-oci"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "tfstate-oci.matheuscarino.com.br"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-oci"
  }
}