data "aws_subnet" "Subnet1" {
  id = "subnet-0b0428c9cf16cd4d5"
}

data "aws_security_group" "Alltraffic" {
  id = "sg-0b6318ff9313f504b"
}