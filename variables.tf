variable "environment" {
  type          = string
  description   = "Environment acronym"
}
variable "cost_center" {
  type          = string
  description   = "Cost Center"
}
# variable "cidr_block" {
#   type          = string
#   description   = "CIDR Block used by VCN"
# }
# variable "cidr_block_public" {
#   type          = string
#   description   = "CIDR Block used by Public subnet"
# }
# variable "cidr_block_private" {
#   type          = string
#   description   = "CIDR Block used by Private subnet"
# }
# variable "cidr_block_endpoint" {
#   type          = string
#   description   = "CIDR Block of subnet used by Kubernetes Endpoints"
# }
# variable "cidr_block_pods" {
#   type          = string
#   description   = "CIDR Block of subnet used by Kubernetes Pods"
# }
# variable "cidr_block_lbs" {
#   type          = string
#   description   = "CIDR Block of subnet used by Kubernetes Load Balancers"
# }
# variable "cidr_block_dbs" {
#   type          = string
#   description   = "CIDR Block of subnet used by Databases"
# }
# variable "cidr_block_nodes" {
#   type          = string
#   description   = "CIDR Block of subnet used by Kubernetes Nodes"
# }
# variable "public_ip_address" {
#   type          = string
#   description   = "Fixed IP Address from my home internet connection"
# }
variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
}
variable "domain" {
  type        = string
  description = "Domain name used to create unique S3 buckets on AWS"
}
variable "instance_shape" {
  type        = string
  description = "Instance Shape for ARM Instances"
}
variable "instance_shape_amd64" {
  type        = string
  description = "Instance Shape for AMD64 Instances"
}
variable "region" {
  type        = string
  description = "The region to provision the resources in"
}
variable "aws_region" {
  type        = string
  description = "The region to provision the resources in"
}
variable "ssh_public_key" {
  type        = string
  description = "SSH Key pair used to secure connect to the Kubernetes nodes"
}
# variable "create_internet_gateway" {
#   description = "whether to create the internet gateway in the vcn. If set to true, creates an Internet Gateway."
#   default     = false
#   type        = bool
# }
# variable "create_nat_gateway" {
#   description = "whether to create a nat gateway in the vcn. If set to true, creates a nat gateway."
#   default     = false
#   type        = bool
# }
# variable "create_service_gateway" {
#   description = "whether to create a service gateway. If set to true, creates a service gateway."
#   default     = false
#   type        = bool
# }