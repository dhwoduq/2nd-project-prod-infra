variable "ami_id" {}
variable "key_name" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "web_subnet_ids" {
  type = list(string)
}

variable "was_subnet_ids" {
  type = list(string)
}

variable "bastion_sg_id" {
  description = "Security group ID for Bastion Host"
  type        = string
}

variable "web_sg_id" {
  description = "Security group ID for Web EC2"
  type        = string
}

variable "was_sg_id" {
  description = "Security group ID for WAS EC2"
  type        = string
}

variable "monitoring_sg_id" {
  description = "Security group ID for Monitoring EC2"
  type        = string
}

variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

