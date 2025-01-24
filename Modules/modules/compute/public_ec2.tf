resource "aws_instance" "Public_servers" {
  # count                       = length(var.instance_names)
  count                       = var.env == "dev" ? 3 : 1 # if env is dev, create 3 instances, otherwise create 1 instance
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  key_name                    = var.key_name # Replace with your key pair name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  subnet_id                   = var.public_subnets[count.index]

  tags = {
    Name   = "Public-${var.instance_names[count.index]}"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}