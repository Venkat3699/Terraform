provider "aws" {
  region = var.region
}


resource "aws_instance" "web_servers" {
  count                       = length(var.instance_names)
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  key_name                    = var.key_name # Replace with your key pair name
  associate_public_ip_address = true

  tags = {
    Name = var.instance_names[count.index]
  }

}