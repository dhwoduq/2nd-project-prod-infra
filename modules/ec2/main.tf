# Bastion EC2 (2개, AZ별로 배치)
resource "aws_instance" "bastion" {
  count         = 2
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = var.key_name
  vpc_security_group_ids = [var.bastion_sg_id]  # 수정됨 ✅

  tags = {
    Name = "${var.env}-bastion-${count.index + 1}"
  }
}

# Web EC2 (2개, AZ별로 배치)
resource "aws_instance" "web" {
  count         = 2
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = var.web_subnet_ids[count.index]
  key_name      = var.key_name
  vpc_security_group_ids = [var.web_sg_id]  # 수정됨 ✅

  tags = {
    Name = "${var.env}-web-${count.index + 1}"
  }
}

# WAS EC2 (2개, AZ별로 배치)
resource "aws_instance" "was" {
  count         = 2
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = var.was_subnet_ids[count.index]
  key_name      = var.key_name
  vpc_security_group_ids = [var.was_sg_id]  # 수정됨 ✅

  tags = {
    Name = "${var.env}-was-${count.index + 1}"
  }
}

# Monitoring EC2 (WAS와 동일한 서브넷에 배치)
resource "aws_instance" "monitoring" {
  count         = 1
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = var.was_subnet_ids[0]
  key_name      = var.key_name
  vpc_security_group_ids = [var.monitoring_sg_id]  # 그대로 유지 ✅

  tags = {
    Name = "${var.env}-monitoring"
  }
}

