data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.record_name}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name        # ✅ ALB DNS 이름
    zone_id                = var.alb_zone_id         # ✅ 하드코딩 대신 변수 사용
    evaluate_target_health = true
  }
}

