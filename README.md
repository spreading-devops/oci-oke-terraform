# OCI - OKE - TERRAFORM

## Building Kubernetes Cluster on Oracle Cloud Infrastructure
```
OKE Kubernetes version: 1.27.2
NodePool OS: Oracle Linux Server 8.8
Image: Oracle-Linux-8.8-aarch64-2023.08.31-0
```
### Infrastructure as Code - Terraform
```
Terraform version: v1.5.7
Terraform backend: AWS S3 + AWS DynamoDB
```

#### List OCI images available
```
$ oci ce node-pool-options get --node-pool-option-id all
```

### Enable Kubernetes Dashboard
Instructions are availabe on kubernetes-dashboard directory.

#### Contribute
If you want to contribute to this project, I will be very happy to help you!