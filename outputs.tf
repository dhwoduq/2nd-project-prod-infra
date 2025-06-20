output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.subnet.public_subnet_ids
}

output "web_subnets" {
  value = module.subnet.web_subnet_ids
}

output "was_subnets" {
  value = module.subnet.was_subnet_ids
}

output "bastion_ips" {
  value = module.ec2.bastion_public_ips
}

output "web_instance_ids" {
  value = module.ec2.web_instance_ids
}

