# Configuring VPC
resource "aws_vpc" "Vpc-Terraform" {
  cidr_block         = var.vpc_cidr
  enable_dns_support = true

  tags = {
    Name = "${var.vpc_name}"
    env  = "${var.env}"
  }
}

# Configuring Internet Gateway
resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name = "${var.IGW_name}"
    env  = "${var.env}"
  }
}

# Configuring Public Subnet
resource "aws_subnet" "Public-Subnet-Terraform" {
  vpc_id                  = aws_vpc.Vpc-Terraform.id
  cidr_block              = var.public_subnet1_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet1_name}"
    env  = "${var.env}"
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
    Name = "${var.Main_Routing_Table}"
    env  = "${var.env}"
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
    Name = "${var.env}-allow_tls-Terraform"
    env  = "${var.env}"
  }
}

resource "aws_instance" "Server-1" {
  ami                         = var.ami # Example AMI
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.Public-Subnet-Terraform.id
  vpc_security_group_ids      = [aws_security_group.allow_tls-Terraform.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    echo "<h1>Welcome to ${var.env}}Terraform-Server-1</h1>" | sudo tee /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
    EOF

  tags = {
    Name = "${var.instance_name}"
  }
}