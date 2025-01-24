region              = "us-east-1"
vpc_cidr            = "10.0.0.0/16"
azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidr = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
env                 = "uat"
instance_type       = "t2.small"
key_name            = "Ravi_Virginia"
instance_names      = ["Jenkins", "Docker", "Kubernetes"]
allowed_ports       = ["22", "80", "8080", "3306"]
amis = {
  ap-south-1     = "ami-00bb6a80f01f03502"
  us-east-1      = "ami-04b4f1a9cf54c11d0"
  us-east-2      = "ami-0cb91c7de36eed2cb"
  ap-southeast-1 = "ami-0672fd5b9210aa093"
}
