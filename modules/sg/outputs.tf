output "bastion_sg_id" {
  description = "Bastion SG ID"
  value       = aws_security_group.bastion_sg.id
}

output "web_sg_id" {
  description = "Web SG ID"
  value       = aws_security_group.web_sg.id
}

output "was_sg_id" {
  description = "WAS SG ID"
  value       = aws_security_group.was_sg.id
}

output "monitoring_sg_id" {
  description = "Monitoring SG ID"
  value       = aws_security_group.monitoring_sg.id
}

