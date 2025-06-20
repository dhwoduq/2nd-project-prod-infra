variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "env" {
  description = "환경 이름 (예: dev, test, prod)"
  type        = string
}
