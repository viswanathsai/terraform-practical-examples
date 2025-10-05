variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-learning"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
  default     = "dev"

  validation {
    condition = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0c02fb55956c7d316"  # Amazon Linux 2
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Owner     = "DevOps Team"
  }
}