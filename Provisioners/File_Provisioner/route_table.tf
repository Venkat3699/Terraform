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
