variable "vpc_id" {
  description = "VPC ID to attach the security group to"
  type        = string
}

variable "name" {
  description = "Prefix for naming"
  type        = string
}

variable "env" {
  description = "환경 이름 (예: dev, test, prod)"
  type        = string
}

variable "was_cidrs" {
  description = "CIDR blocks for the WAS subnet"
  type        = list(string)
}

