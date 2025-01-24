output "vpc_id" {
  value = aws_vpc.Vpc-Terraform.id
}

output "env" {
  value = var.env
}

# output "Public-Subnets" {
#   value = [for i in range(length(aws_subnet.Public-Subnets)) : aws_subnet.Public-Subnets[i].id]
# }

# output "Private-Subnets" {
#   value = [for i in range(length(aws_subnet.Private-Subnets)) : aws_subnet.Private-Subnets[i].id]
# }

output "Public-Subnets" {
  value = aws_subnet.Public-Subnets.*.id
}

output "Private-Subnets" {
  value = aws_subnet.Private-Subnets.*.id
}