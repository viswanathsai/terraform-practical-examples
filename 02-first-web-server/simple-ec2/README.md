# Chapter 2: First Web Server

## What This Example Does
- Creates a complete VPC with public subnet
- Launches an EC2 instance with a web server
- Sets up all networking (Internet Gateway, Route Tables, Security Groups)
- Installs Apache and creates a custom web page

## Prerequisites
- SSH key pair: Run `ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""`

## How to Use
1. Navigate to this directory: `cd 02-first-web-server/simple-ec2`
2. Generate SSH key if you haven't: `ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""`
3. Initialize: `terraform init`
4. Plan: `terraform plan`
5. Apply: `terraform apply`
6. Visit the website URL shown in outputs
7. SSH into server: Use the command from outputs
8. Clean up: `terraform destroy`

## What You'll Learn
- Complete VPC setup
- Security Groups and networking
- EC2 instance deployment
- User data scripts
- SSH key management

## Expected Cost
- FREE (within AWS free tier)
- t3.micro instance: 750 hours free per month
