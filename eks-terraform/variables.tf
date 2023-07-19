# AWS access key used to create infrastructure
variable "aws_access_key" {
 default  = ""
}

# AWS secret key used to create infrastructure
variable "aws_secret_key" {
 default = ""
}

# AWS region used for all resources
variable "aws_region" {
 default = "us-east-2"
}

# Prefix of the resources that will be created under this module
variable "resource_prefix" {
 default = "yo"
}
