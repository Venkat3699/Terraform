terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-s3-practise"
    key    = "demo-tf-backup.tfstate"
    region = "ap-south-1"
  }
}

# Configure the AWS Providers
provider "aws" {
  region = "ap-south-1"
}

# Configuring VPC
resource "aws_vpc" "Vpc-Terraform" {
  cidr_block         = "10.0.0.0/16"
  enable_dns_support = true

  tags = {
    Name = "Vpc-Terraform"
  }
}

# Configuring Internet Gateway
resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name = "Igw-Terraform"
  }
}

# Configuring Public Subnet
resource "aws_subnet" "Public-Subnet-Terraform" {
  vpc_id                  = aws_vpc.Vpc-Terraform.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-Terraform"
  }
}

# Configuring Route Table
resource "aws_route_table" "Rt-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw-Terraform.id
  }

  tags = {
    Name = "Rt-Terraform"
  }
}

# Configuring Route Table Association
resource "aws_route_table_association" "Rta-Pubilc-Terraform" {
  subnet_id      = aws_subnet.Public-Subnet-Terraform.id
  route_table_id = aws_route_table.Rt-Terraform.id
}


# Configuring Security Group
resource "aws_security_group" "allow_tls-Terraform" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Vpc-Terraform.id

  ingress {
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
    Name = "allow_tls-Terraform"
  }
}
