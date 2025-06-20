resource "random_id" "suffix" {
  byte_length = 2
}

resource "aws_lb" "this" {
  name               = "${var.env}-${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg_id]

  tags = {
    Name = "${var.env}-${var.name}-alb"
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.env}-${var.name}-tg-${random_id.suffix.hex}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
    port                = "traffic-port"
  }

  tags = {
    Name = "${var.env}-${var.name}-tg-${random_id.suffix.hex}"
  }
}

# HTTP 리스너 (80 → 443 리디렉션)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS 리스너 (443 + 인증서 적용)
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group_attachment" "web" {
  count            = length(var.web_instance_ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.web_instance_ids[count.index]
  port             = 80
}

