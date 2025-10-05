# Chapter 4: Data Sources

## Learning Objectives
- Understand data sources vs resources
- Learn to fetch existing AWS resources
- Use data in other resources
- Practice with common AWS data sources

## What This Demonstrates
- Finding latest AMI automatically
- Getting available AZs dynamically
- Retrieving AWS account information
- Using data source outputs in resources

## Key Data Sources Used
- `aws_ami`: Find AMI by filters
- `aws_availability_zones`: Get AZ list
- `aws_caller_identity`: Account info

## Benefits of Data Sources
- Always use latest AMI
- Adapt to different regions
- Avoid hardcoding resource IDs
- Make configurations portable
