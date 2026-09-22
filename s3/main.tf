terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-2"
}

resource "random_id" "random_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "my-bucket-${random_id.random_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3policy" {
  bucket = aws_s3_bucket.s3bucket.id

  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "arn:aws:s3:::${aws_s3_bucket.s3bucket.id}/*"
        }
      ]
    }

  )
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.s3bucket.id

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_object" "s3bucket_oject" {
  bucket       = aws_s3_bucket.s3bucket.bucket
  source       = "./index.html"
  key          = "./index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "s3bucket_oject2" {
  bucket       = aws_s3_bucket.s3bucket.bucket
  source       = "./script.js"
  key          = "./script.js"
  content_type = "application/javascript"
}



output "url" {
  value = "http://${aws_s3_bucket_website_configuration.example.website_endpoint}"
}

