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