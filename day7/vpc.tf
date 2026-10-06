resource "aws_vpc" "vpcdemo" {
  cidr_block       = "13.0.0.0/16"
  instance_tenancy = "default"
  

  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "subdemo-priv" {
  vpc_id     = aws_vpc.vpcdemo.id
  cidr_block = "13.0.1.0/24"
  

  tags = {
    Name = "private-sub"
  }
}

resource "aws_subnet" "subdemo-pub" {
  vpc_id     = aws_vpc.vpcdemo.id
  availability_zone = "us-east-1a"
  cidr_block = "13.0.2.0/24"

  tags = {
    Name = "public-sub"
  }
}

resource "aws_internet_gateway" "gw-demo" {
  vpc_id = aws_vpc.vpcdemo.id

  tags = {
    Name = "demo-gw"
  }
}

resource "aws_route_table" "route-demo" {
  vpc_id = aws_vpc.vpcdemo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-demo.id
  }
    tags = {
    Name = "dmeo-route"
  }
}

resource "aws_route_table_association" "RTA-demo" {
  subnet_id      = aws_subnet.subdemo-pub.id
  route_table_id = aws_route_table.route-demo.id
}
