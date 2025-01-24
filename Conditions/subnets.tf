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