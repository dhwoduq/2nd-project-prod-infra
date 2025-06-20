variable "name" {}

variable "vpc_id" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {}

variable "web_instance_ids" {
  type = list(string)
}

variable "env" {
  description = "환경 이름 (예: dev, test, prod)"
  type        = string
}

# ✅ 여기에 인증서 ARN 변수 추가
variable "certificate_arn" {
  description = "HTTPS 리스너에 사용할 ACM 인증서 ARN"
  type        = string
}

