# Chapter 1: Your First Terraform Configuration
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# Get current AWS account info
data "aws_caller_identity" "current" {}

# Create a simple S3 bucket for testing
resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-first-terraform-bucket-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "My First Terraform Bucket"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.test_bucket.id
}

output "account_id" {
  description = "Your AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}