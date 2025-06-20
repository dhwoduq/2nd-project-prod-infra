variable "name" {}

variable "vpc_cidr" {}

variable "public_cidrs" {
  type = list(string)
}

variable "web_cidrs" {
  type = list(string)
}

variable "was_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "ami_id" {
  description = "AMI ID for EC2 instances (used for both WAS, Web, and Monitoring EC2)"
  type        = string
}

variable "key_name" {}

variable "domain_name" {
  type = string
}

variable "record_name" {
  type        = string
  description = "도메인 레코드 이름 (예: www, dev, test)"
}

variable "env" {
  description = "환경 이름 (예: dev, test, prod)"
  type        = string
}

# ✅ 추가: HTTPS용 인증서 ARN
variable "certificate_arn" {
  description = "ACM 인증서 ARN (HTTPS용)"
  type        = string
}

