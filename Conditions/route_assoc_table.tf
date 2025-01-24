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