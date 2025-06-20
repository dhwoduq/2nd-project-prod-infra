variable "vpc_id" {}
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
variable "name" {}

variable "env" {
  description = "환경 이름 (예: dev, test, prod)"
  type        = string
}

