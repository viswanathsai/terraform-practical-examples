# Chapter 4: Data Sources
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

# Data source to find the latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Data source to get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Data source to get current AWS account info
data "aws_caller_identity" "current" {}

# Use data sources in resources
resource "aws_instance" "web" {
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t3.micro"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name      = "DataSource-Example"
    AMI       = data.aws_ami.amazon_linux.name
    AccountID = data.aws_caller_identity.current.account_id
  }
}