# Configuring VPC
resource "aws_vpc" "Vpc-Terraform" {
  cidr_block         = var.vpc_cidr
  enable_dns_support = true

  tags = {
    Name   = "${var.env}_VPC-tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

# Configuring Internet Gateway
resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name   = "${var.env}_IGW-tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

# Configuring Public and Private Subnet
resource "aws_subnet" "Public-Subnets" {
  vpc_id            = aws_vpc.Vpc-Terraform.id
  count             = length(var.public_subnet_cidr)
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = var.azs[count.index]

  tags = {
    Name   = "${var.env}_Public_Subnet-${count.index + 1}-tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

resource "aws_subnet" "Private-Subnets" {
  vpc_id            = aws_vpc.Vpc-Terraform.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = var.azs[count.index]

  tags = {
    Name   = "${var.env}_Private_Subnet-${count.index + 1}-tf}"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

# Configuring Route Table for Public Subnet
resource "aws_route_table" "Public-Rt-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw-Terraform.id
  }

  tags = {
    Name   = "${var.env}_Public-RT"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

# Configuring Route Table for Private Subnet
resource "aws_route_table" "Private-Rt-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name   = "${var.env}_Private-RT"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

# Configuring Route Table Association for Public and Private
resource "aws_route_table_association" "Rta-Pubilc-Terraform" {
  count          = length(aws_subnet.Public-Subnets)
  subnet_id      = aws_subnet.Public-Subnets[count.index].id
  route_table_id = aws_route_table.Public-Rt-Terraform.id
}

resource "aws_route_table_association" "Rta-Private-Terraform" {
  count          = length(aws_subnet.Private-Subnets)
  subnet_id      = aws_subnet.Private-Subnets[count.index].id
  route_table_id = aws_route_table.Private-Rt-Terraform.id
}

# Configuring Security Group
# Configuring Security Group
resource "aws_security_group" "allow_tls-Terraform" {
  name        = "allow_multiple_ports"
  description = "Security group to allow multiple ports"
  vpc_id      = aws_vpc.Vpc-Terraform.id # Ensure the security group is associated with the correct VPC

  # Loop through allowed ports to create ingress rules
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name   = "${var.env}_Sg-tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}


# Creating EC2 Instances
resource "aws_instance" "web_servers" {
  count                       = length(var.instance_names)
  ami                         = var.ami # Replace with your desired AMI
  instance_type               = var.instance_type
  key_name                    = var.key_name # Replace with your key pair name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_tls-Terraform.id]
  subnet_id                   = aws_subnet.Public-Subnets[count.index].id

  tags = {
    Name = var.instance_names[count.index]
  }
}