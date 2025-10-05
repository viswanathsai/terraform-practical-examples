output "ami_info" {
  description = "Information about the AMI used"
  value = {
    id           = data.aws_ami.amazon_linux.id
    name         = data.aws_ami.amazon_linux.name
    description  = data.aws_ami.amazon_linux.description
    architecture = data.aws_ami.amazon_linux.architecture
  }
}

output "availability_zones" {
  description = "Available AZs in the region"
  value       = data.aws_availability_zones.available.names
}

output "account_info" {
  description = "AWS account information"
  value = {
    account_id = data.aws_caller_identity.current.account_id
    user_id    = data.aws_caller_identity.current.user_id
    arn        = data.aws_caller_identity.current.arn
  }
}