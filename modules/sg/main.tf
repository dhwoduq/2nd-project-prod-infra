# Bastion Security Group
resource "aws_security_group" "bastion_sg" {
  name        = "${var.env}-${var.name}-sg-bastion"
  description = "Bastion SG (company public IP only)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.248.40.226/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ❗️테스트 끝나면 제거 권장
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}-sg-bastion"
  }
}

# Web Security Group
resource "aws_security_group" "web_sg" {
  name        = "${var.env}-${var.name}-sg-web"
  description = "Web servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}-sg-web"
  }
}

# WAS Security Group
resource "aws_security_group" "was_sg" {
  name        = "${var.env}-${var.name}-sg-was"
  description = "WAS servers"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}-sg-was"
  }
}

# Monitoring Security Group
resource "aws_security_group" "monitoring_sg" {
  name        = "${var.env}-${var.name}-sg-monitoring"
  description = "Monitoring server"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}-sg-monitoring"
  }
}

# SG Rules

# Bastion → Web SSH
resource "aws_security_group_rule" "ssh_bastion_to_web" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
}

# Bastion → WAS SSH
resource "aws_security_group_rule" "ssh_bastion_to_was" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.was_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
}

# Monitoring → Web (9100)
resource "aws_security_group_rule" "monitoring_to_web_9100" {
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.monitoring_sg.id
}

# Monitoring → WAS (9100)
resource "aws_security_group_rule" "monitoring_to_was_9100" {
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = aws_security_group.was_sg.id
  source_security_group_id = aws_security_group.monitoring_sg.id
}

# Bastion → Monitoring Grafana (3000)
resource "aws_security_group_rule" "bastion_to_monitoring_3000" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.monitoring_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
}

# Bastion → Monitoring Prometheus (9090)
resource "aws_security_group_rule" "bastion_to_monitoring_9090" {
  type                     = "ingress"
  from_port                = 9090
  to_port                  = 9090
  protocol                 = "tcp"
  security_group_id        = aws_security_group.monitoring_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
}

# Web → WAS 4000
resource "aws_security_group_rule" "web_to_was_4000" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 4000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.was_sg.id
  source_security_group_id = aws_security_group.web_sg.id
}

# Monitoring → WAS 4000
resource "aws_security_group_rule" "monitoring_to_was_4000" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 4000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.was_sg.id
  source_security_group_id = aws_security_group.monitoring_sg.id
}

# Monitoring → Web 9113
resource "aws_security_group_rule" "monitoring_to_web_9113" {
  type                     = "ingress"
  from_port                = 9113
  to_port                  = 9113
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.monitoring_sg.id
}

