module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  cidr = var.vpc_cidr
  azs  = var.availability_zones
  //private_subnets = var.priv_net_cidrs
  public_subnets = var.pub_net_cidrs

  enable_nat_gateway = false
  enable_vpn_gateway = false
  enable_ipv6        = false

  tags = {
    "Name" = var.vpc_name
  }
}