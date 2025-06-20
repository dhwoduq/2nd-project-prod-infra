variable "vpc_id" {}
variable "public_subnet_ids" { type = list(string) }
variable "was_subnet_ids" { type = list(string) }
variable "web_subnet_ids" { type = list(string) }
variable "name" {}
variable "env" {
  description = "환경 이름 (예: dev, test, prod)"
  type        = string
}

