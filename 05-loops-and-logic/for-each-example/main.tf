# Chapter 5: Loops and Logic
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

# Define users as a map
locals {
  users = {
    alice = {
      department = "engineering"
      role       = "developer"
    }
    bob = {
      department = "marketing"
      role       = "manager"
    }
    carol = {
      department = "engineering"
      role       = "devops"
    }
  }
}

# Create S3 buckets using for_each
resource "aws_s3_bucket" "user_buckets" {
  for_each = local.users

  bucket = "user-${each.key}-${random_id.bucket_suffix.hex}"

  tags = {
    Name       = "${each.key}-bucket"
    User       = each.key
    Department = each.value.department
    Role       = each.value.role
  }
}

# Create random suffix for bucket names
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create IAM users using for_each
resource "aws_iam_user" "users" {
  for_each = local.users

  name = each.key
  path = "/${each.value.department}/"

  tags = {
    Department = each.value.department
    Role       = each.value.role
  }
}

# Conditional resource creation
resource "aws_s3_bucket" "admin_bucket" {
  count = contains([for user, info in local.users : info.role], "devops") ? 1 : 0

  bucket = "admin-bucket-${random_id.bucket_suffix.hex}"

  tags = {
    Name = "admin-bucket"
    Type = "administrative"
  }
}