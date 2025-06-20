variable "domain_name" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "alb_zone_id" {  # ✅ 추가
  description = "ALB의 zone ID (Route53 alias에 필요)"
  type        = string
}

variable "record_name" {
  type    = string
  default = "www"
}

variable "name" {
  type = string
}

variable "env" {
  description = "환경 이름 (예: dev, test, prod)"
  type        = string
}

