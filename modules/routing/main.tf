resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = { Name = "${var.name}-igw" }
}

resource "aws_eip" "nat" {
  count  = 2
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  count         = 2
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]
  tags = { Name = "${var.name}-nat-${count.index + 1}" }
}

# One shared public route table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.name}-public-rt" }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_ids)
  subnet_id = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# Two route tables for WAS (each mapped to one NAT GW)
resource "aws_route_table" "was_private" {
  count  = 2
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = { Name = "${var.name}-was-private-rt-${count.index + 1}" }
}

resource "aws_route_table_association" "was_private" {
  count = 2
  subnet_id = var.was_subnet_ids[count.index]
  route_table_id = aws_route_table.was_private[count.index].id
}

resource "aws_route_table" "web_private" {
  count  = 2
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
    Name = "${var.name}-web-private-rt-${count.index + 1}"
  }
}

resource "aws_route_table_association" "web_private" {
  count          = 2
  subnet_id      = var.web_subnet_ids[count.index]
  route_table_id = aws_route_table.web_private[count.index].id
}
