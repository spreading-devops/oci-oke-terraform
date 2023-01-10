variable "environment" {
  type          = string
  description   = "Environment acronym"
}
variable "cost_center" {
  type          = string
  description   = "Cost Center"
}
variable "cidr_block" {
  type          = string
  description   = "CIDR Block used by VCN"
}
variable "cidr_block_public" {
  type          = string
  description   = "CIDR Block used by Public subnet"
}
variable "cidr_block_pods" {
  type          = string
  description   = "CIDR Block of subnet used by Kubernetes Pods"
}
variable "cidr_block_lbs" {
  type          = string
  description   = "CIDR Block of subnet used by Kubernetes Load Balancers"
}
variable "cidr_block_nodes" {
  type          = string
  description   = "CIDR Block of subnet used by Kubernetes Nodes"
}
variable "cidr_block_endpoints" {
  type          = string
  description   = "CIDR Block of subnet used by Kubernetes Endpoints"
}
variable "cidr_block_private" {
  type          = string
  description   = "CIDR Block used by Private subnet"
}
variable "public_ip_address" {
  type          = string
  description   = "Fixed IP Address from my home internet connection"
}
variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
}
variable "region" {
  type        = string
  description = "The region to provision the resources in"
}
variable "ssh_public_key" {
  type        = string
  description = "SSH Key pair used to secure connect to the Kubernetes nodes"
}