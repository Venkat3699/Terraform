resource "aws_instance" "Private_servers" {
  # count                       = length(var.instance_names)
  count         = var.env == "dev" ? 3 : 1 # if env is dev, create 3 instances, otherwise create 1 instance
  ami           = lookup(var.amis, var.region)
  instance_type = var.instance_type
  key_name      = var.key_name # Replace with your key pair name
  subnet_id     = var.private_subnets[count.index]

  tags = {
    Name   = "Private-${var.instance_names[count.index]}"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}