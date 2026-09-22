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
    name   = "tag:sga"
    values = ["sg"]
  }
}

data "aws_vpc" "vpc-name" {
  tags = {
    Name = "dev-vpc"
  }
}

data "aws_subnet" "name" {
  tags = {
    public = "subnet"
  }
}


resource "aws_instance" "example" {
  ami           = "ami-0199ac7c9fbf9ed83"
  instance_type = "t3.micro"
  subnet_id     = data.aws_subnet.name.id
  vpc_security_group_ids = [data.aws_security_group.name.id]

  tags = {
    Name = "ExampleInstance"
  }
}
output "IDs" {
  value = {
    aws_security_group_id = data.aws_security_group.name.id
    aws_vpc_id            = data.aws_vpc.vpc-name.id
    subnet_id             = data.aws_subnet.name.id
  }
}
