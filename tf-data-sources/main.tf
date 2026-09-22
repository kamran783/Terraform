terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

data "aws_security_group" "name" {
  filter {
    name   = "tag:admin"
    values = ["pass"]
  }
}

data "aws_vpc" "vpc-name" {
  tags = {
    Name = "dev-vpc"
  }
}

output "aws_valuues" {
  description = "the region is"
  value       = data.aws_vpc.vpc-name.id
}

