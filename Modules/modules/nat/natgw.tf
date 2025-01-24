resource "aws_eip" "natgw_eip" {
  count  = length(var.public_subnets) # Create one EIP for each NAT Gateway
  domain = "vpc"                      # Ensure this is set if you are using it in a VPC

  tags = {
    Name   = "${var.env}_eip-tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = var.env
  }
}

resource "aws_nat_gateway" "natgw" {
  count         = length(var.public_subnets)        # Set count based on the number of public subnets
  allocation_id = aws_eip.natgw_eip[count.index].id # Reference the EIP using count.index
  subnet_id     = var.public_subnets[count.index]   # Accessing the subnet ID using count.index

  tags = {
    Name   = "${var.env}_nat-tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = var.env
  }
}