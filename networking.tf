# Create a VPC
resource "aws_vpc" "vpc-dtu" {
  cidr_block = "10.0.0.0/27"
  tags = {
    Name = "VPC-DTU"
  }
}
resource "aws_subnet" "sub-exxt" {
  vpc_id     = aws_vpc.vpc-dtu.id
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "Internet"
  }
}
resource "aws_subnet" "sub-int" {
  vpc_id     = aws_vpc.vpc-dtu.id
  cidr_block = "10.0.0.16/28"

  tags = {
    Name = "Intranet"
  }
}
resource "aws_internet_gateway" "gtwyintr" {
  vpc_id = aws_vpc.vpc-dtu.id

  tags = {
    Name = "Gateway Principal"
  }
}
resource "aws_route_table" "tbl-externa" {
  vpc_id = aws_vpc.vpc-dtu.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtwyintr.id
  }

  tags = {
    Name = "Tabla rutas Externa"
  }
}
resource "aws_route_table_association" "asocia-tbl-extrna" {
  subnet_id      = aws_subnet.sub-exxt.id
  route_table_id = aws_route_table.tbl-externa.id
}