output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "was_subnet_ids" {
  value = aws_subnet.was[*].id
}

output "web_subnet_ids" {
  value = aws_subnet.web[*].id
}
