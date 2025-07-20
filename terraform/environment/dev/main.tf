module "network" {
  source             = "../../modules/network"
  cidr_block         = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}


module "compute" {
  source         = "../../modules/compute"
  vpc_id         = module.network.vpc_id
  subnet_id      = module.network.public_subnet_id
  instance_type  = var.instance_type
  instance_count = var.instance_count
  key_name       = var.key_name
}
