module "dev_vpc" {
  source              = "../modules/networks"
  vpc_cidr            = "10.0.0.0/16"
  azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidr = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  env                 = "dev"
}

module "dev_sg" {
  source         = "../modules/sg"
  vpc_id         = module.dev_vpc.vpc_id
  env            = module.dev_vpc.env
  ingress_values = ["22", "80", "443", "8080", "3306"]
}

module "dev_ec2" {
  source         = "../modules/compute"
  env            = module.dev_vpc.env
  instance_type  = "t2.micro"
  instance_names = ["Jenkins", "Docker", "Kubernetes"]
  key_name       = "Ravi_Virginia"
  ami            = "ami-04b4f1a9cf54c11d0"
}