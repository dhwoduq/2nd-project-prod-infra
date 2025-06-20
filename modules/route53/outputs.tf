output "fqdn" {
  value = "${var.record_name}.${var.domain_name}"
}

