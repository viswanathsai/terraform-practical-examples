# Chapter 2: Your First Web Server
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

  default_tags {
    tags = {
      Project   = "Terraform Learning"
      ManagedBy = "Terraform"
      Chapter   = "02"
    }
  }
}

# Get the latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "MyFirstVPC"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyFirstIGW"
  }
}

# Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
    Type = "Public"
  }
}

# Create Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create Security Group
resource "aws_security_group" "web_server" {
  name_prefix = "web-server-sg-"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServerSecurityGroup"
  }
}

# Create Key Pair (you need to have ~/.ssh/id_rsa.pub)
resource "aws_key_pair" "web_server_key" {
  key_name   = "my-web-server-key"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = "WebServerKey"
  }
}

# Create EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.web_server_key.key_name
  vpc_security_group_ids = [aws_security_group.web_server.id]
  subnet_id              = aws_subnet.public.id

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    server_name = "My First Terraform Web Server"
  }))

  tags = {
    Name = "MyFirstWebServer"
    Type = "WebServer"
  }
}