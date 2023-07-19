# AWS access key used to create infrastructure
variable "aws_access_key" {
 default  = "AKIA3ZKWXZJC5DIG4UHF"
}

# AWS secret key used to create infrastructure
variable "aws_secret_key" {
 default = "D/990ijR0aM48jr/K80WsuS00AExYZ8mZjoiJYR7"
}

# AWS region used for all resources
variable "aws_region" {
 default = "us-east-2"
}

# Prefix of the resources that will be created under this module
variable "resource_prefix" {
 default = "yo"
}
