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

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.natgw_id[0]
  }
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