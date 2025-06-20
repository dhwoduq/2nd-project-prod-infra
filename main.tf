module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  name     = var.name
  env      = var.env
}

module "subnet" {
  source        = "./modules/subnet"
  vpc_id        = module.vpc.vpc_id
  public_cidrs  = var.public_cidrs
  web_cidrs     = var.web_cidrs
  was_cidrs     = var.was_cidrs
  azs           = var.azs
  name          = var.name
  env           = var.env
}

module "sg" {
  source     = "./modules/sg"
  vpc_id     = module.vpc.vpc_id
  name       = var.name
  env        = var.env
  was_cidrs  = var.was_cidrs
}

module "routing" {
  source             = "./modules/routing"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnet.public_subnet_ids
  web_subnet_ids     = module.subnet.web_subnet_ids
  was_subnet_ids     = module.subnet.was_subnet_ids
  name               = var.name
  env                = var.env
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = var.ami_id
  key_name           = var.key_name
  public_subnet_ids  = module.subnet.public_subnet_ids
  web_subnet_ids     = module.subnet.web_subnet_ids
  was_subnet_ids     = module.subnet.was_subnet_ids

  bastion_sg_id      = module.sg.bastion_sg_id
  web_sg_id          = module.sg.web_sg_id
  was_sg_id          = module.sg.was_sg_id
  monitoring_sg_id   = module.sg.monitoring_sg_id

  env                = var.env
  vpc_id             = module.vpc.vpc_id
}

module "alb" {
  source             = "./modules/alb"
  name               = var.name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnet.public_subnet_ids
  alb_sg_id          = module.sg.web_sg_id
  web_instance_ids   = module.ec2.web_instance_ids
  certificate_arn    = var.certificate_arn
  env                = var.env
}

module "route53" {
  source        = "./modules/route53"
  name          = var.name
  domain_name   = var.domain_name
  alb_dns_name  = module.alb.alb_dns_name
  alb_zone_id   = module.alb.alb_zone_id
  record_name   = var.record_name
  env           = var.env
}

