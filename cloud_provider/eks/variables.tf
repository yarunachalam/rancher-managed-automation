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

variable "aws_az1" {
  type = string
  description = "AWS availability zone 1 for the aws_region"
}

variable "aws_az2" {
  type = string
  description = "AWS availability zone 2 for the aws_region"
}

# Prefix of the resources that will be created under this module
variable "resource_prefix" {
 type     = string
 description = "prefix of the resources that will be created under this module"
}

variable "rancher_url" { }

variable "rancher_token" { }

# Hack: Time to wait for Kubernetes to deploy
variable "delaysec" {
	default = 120
}
