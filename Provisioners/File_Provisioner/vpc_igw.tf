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