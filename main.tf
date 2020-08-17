module "okta" {
  source       = "./okta"
  project      = var.oktaasa_project
  group        = var.oktaasa_group
}

module "net" {
  source             = "./network"
  name               = var.name
  environment        = var.environment
  availability_zones = ["us-east-2b", "us-east-2c"]
  public_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "instances" {
  source           = "./instances"
  vpc_id           = module.net.vpc_id
  name             = var.name
  environment      = var.environment
  instances        = var.instances
  subnet           = module.net.public_subnet_ids[0]
  sftd_version     = var.sftd_version
  enrollment_token = module.okta.enrollment_token
}

