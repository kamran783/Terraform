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

locals {
  name = "project"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${local.name}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.${count.index}.0/24"

  count = 2

  tags = {
    Name = "${local.name}-subnet-${count.index}"
  }
}

# resource "aws_instance" "main" {
#   count         = length(var.ec2_config)
#   ami           = var.ec2_config[count.index].ami
#   instance_type = var.ec2_config[count.index].instance_type

#   subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))

#   tags = {
#     Name = "${local.name}-instance-${count.index}"
#   }
# }

# using the for_each method

resource "aws_instance" "main" {
  for_each = var.ec2_map
  #we will get each.key and each.value

  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.main))
  tags = {
    Name = "${local.name}-instance-${each.key}"
  }
}
