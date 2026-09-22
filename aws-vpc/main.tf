terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-2"
}

# create an vpc
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

#create the subnets
resource "aws_subnet" "private-subnet-myvpc" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private-subnet-myvpc"
  }
}


resource "aws_subnet" "public-subnet-myvpc" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-subnet-myvpc"
  }
}

#create a igw
resource "aws_internet_gateway" "igw-myvpc" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "igw-myvpc"
  }
}

#create a route table
resource "aws_route_table" "rt-myvpc" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-myvpc.id
  }

}


resource "aws_route_table_association" "my-routeAsso" {
  route_table_id = aws_route_table.rt-myvpc.id
  subnet_id      = aws_subnet.public-subnet-myvpc.id
}

resource "aws_instance" "myinstance" {      
    ami = "ami-0199ac7c9fbf9ed83"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public-subnet-myvpc.id

    tags = {
        Name = "server"
    }

}