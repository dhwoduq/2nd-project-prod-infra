output "bastion_public_ips" {
  value = aws_instance.bastion[*].public_ip
}

output "web_instance_ids" {
  value = aws_instance.web[*].id
}

