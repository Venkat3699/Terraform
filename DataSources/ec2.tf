terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-s3-practise"
    key    = "dataSource-backup.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "Server-1" {
  ami                         = "ami-00bb6a80f01f03502" # Example AMI
  instance_type               = "t2.medium"
  key_name                    = "Ravi_Mumbai"
  subnet_id                   = data.aws_subnet.Subnet1.id
  vpc_security_group_ids      = [data.aws_security_group.Alltraffic.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    echo "<h1>Welcome to Terraform-Server-1</h1>" | sudo tee /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
    EOF

  tags = {
    Name = "Nginx-server"
  }
}