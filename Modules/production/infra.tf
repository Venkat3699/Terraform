module "prod_vpc" {
  source              = "../modules/networks"
  vpc_cidr            = "192.168.0.0/16"
  azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnet_cidr  = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  private_subnet_cidr = ["192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
  env                 = "prod"
}

module "prod_sg" {
  source         = "../modules/sg"
  vpc_id         = module.prod_vpc.vpc_id
  env            = module.prod_vpc.env
  ingress_values = ["22", "80", "443", "8080", "3306"]
}

module "prod_ec2" {
  source          = "../modules/compute"
  env             = module.prod_vpc.env
  instance_type   = "t2.small"
  instance_names  = ["Jenkins", "Docker", "Kubernetes"]
  key_name        = "Ravi_Virginia"
  region          = var.region
  public_subnets  = module.prod_vpc.Public-Subnets
  private_subnets = module.prod_vpc.Private-Subnets
  sg_id           = module.prod_sg.sg_id
  amis = {
    ap-south-1     = "ami-00bb6a80f01f03502"
    us-east-1      = "ami-04b4f1a9cf54c11d0"
    us-east-2      = "ami-0cb91c7de36eed2cb"
    ap-southeast-1 = "ami-0672fd5b9210aa093"
  }
}