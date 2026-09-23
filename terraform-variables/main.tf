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

resource "aws_instance" "example"{
    ami = "ami-0199ac7c9fbf9ed83"
    instance_type = var.aws_instance_type

    root_block_device {
        volume_size = var.root_volume_size
        volume_type = var.root_volume_type
    }
}