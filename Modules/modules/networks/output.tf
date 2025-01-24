output "vpc_id" {
  value = aws_vpc.Vpc-Terraform.id
}

output "env" {
  value = var.env
}