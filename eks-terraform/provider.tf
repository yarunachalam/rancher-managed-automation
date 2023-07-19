provider "aws" {
  profile = "terraform"
  region  = var.aws_region
  access_key = var.aws_access_key 
  secret_key = var.aws_secret_key 
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21"
    }
  }
}
