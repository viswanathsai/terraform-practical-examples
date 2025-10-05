# Chapter 3: Basic Variables and Locals
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
  region = var.aws_region
}

# Simple EC2 instance with variables
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-server"
  })
}