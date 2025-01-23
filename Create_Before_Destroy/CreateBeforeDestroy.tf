provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Server-1" {
  ami                         = "ami-00bb6a80f01f03502"
  instance_type               = "t2.micro"
  key_name                    = "Ravi_Mumabi"
  availability_zone           = "ap-south-1a"
  associate_public_ip_address = true

  tags = {
    Name  = "Server-1"
    owner = "Ravi"
  }
  lifecycle {
    create_before_destroy = true # It will create the instance after that Delete the instance
  }
}