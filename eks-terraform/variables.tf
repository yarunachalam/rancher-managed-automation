# AWS access key used to create infrastructure
variable "aws_access_key" {
 type     = string
 description = "AWS access key"
}

# AWS secret key used to create infrastructure
variable "aws_secret_key" {
 type     = string
 description = "AWS secret key"
}

# AWS region used for all resources
variable "aws_region" {
 type     = string
 description = "AWS availability zone 1 for the aws_region"
}

# Prefix of the resources that will be created under this module
variable "resource_prefix" {
 type     = string
 description = "prefix of the resources that will be created under this module"
}
