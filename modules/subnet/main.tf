resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "was" {
  count             = 2
  vpc_id            = var.vpc_id
  cidr_block        = var.was_cidrs[count.index]
  availability_zone = var.azs[count.index % length(var.azs)]

  tags = {
    Name = "${var.env}-was-private-${count.index + 1}"
  }
}

resource "aws_subnet" "web" {
  count             = 2
  vpc_id            = var.vpc_id
  cidr_block        = var.web_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.env}-web-${count.index + 1}"
  }
}

