# Chapter 3: Basic Variables and Locals

## Learning Objectives
- Understand variable declaration and usage
- Learn about variable types and validation
- Practice using variables in resources
- Understand locals vs variables

## What This Creates
- Single EC2 instance using variables
- Demonstrates variable types: string, map
- Shows variable validation
- Uses merge() function for tags

## How to Use
1. `terraform init`
2. `terraform apply` (uses defaults)
3. Or customize: `terraform apply -var="environment=prod" -var="instance_type=t3.small"`
4. `terraform destroy`

## Key Concepts
- Variable declarations with descriptions
- Default values
- Variable validation
- Using variables in resources
- Tag merging with merge() function
