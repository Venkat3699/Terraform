# Creating EC2 Instances
resource "aws_instance" "web_servers" {
  # count                       = length(var.instance_names)
  count                       = var.env == "dev" ? 3 : 1 # if env is dev, create 3 instances, otherwise create 1 instance
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  key_name                    = var.key_name # Replace with your key pair name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_tls-Terraform.id]
  subnet_id                   = aws_subnet.Public-Subnets[count.index].id

  tags = {
    Name   = var.instance_names[count.index]
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}
