terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "my-bucket-8a23d5c2cb97f58a"
    key    = "secret.tfstate"
    region = "ap-south-2"
  }
}


