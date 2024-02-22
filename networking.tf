# Create a VPC
resource "aws_vpc" "VPC-DTU" {
  cidr_block = "10.0.0.0/27"
  tags = {
    Name = "VPC-DTU"
  }
}
resource "aws_subnet" "SUB-EXT" {
  vpc_id     = aws_vpc.VPC-DTU.id
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "Internet"
  }
}
resource "aws_subnet" "SUB-INT" {
  vpc_id     = aws_vpc.VPC-DTU.id
  cidr_block = "10.0.0.16/28"

  tags = {
    Name = "Intranet"
  }
}
resource "aws_internet_gateway" "GTWY" {
  vpc_id = aws_vpc.VPC-DTU.id

  tags = {
    Name = "Gateway Principal"
  }
}
resource "aws_route_table" "TBL-EXTERNA" {
  vpc_id = aws_vpc.VPC-DTU.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GTWY.id
  }

  tags = {
    Name = "Tabla rutas Externa"
  }
}
resource "aws_route_table_association" "ASOCIA-TBL-EXT" {
  subnet_id      = aws_subnet.SUB-EXT.id
  route_table_id = aws_route_table.TBL-EXTERNA.id
}