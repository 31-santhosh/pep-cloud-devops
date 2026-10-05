resource "aws_instance" "testec2e" {
  ami           = "ami-0b6d9d3d33ba97d99"
  subnet_id = aws_subnet.subdemo-pub.id
  instance_type = "t3.micro"
  key_name      = "webserver1"
  vpc_security_group_ids = ["sg-09fb38e420369907c"]

  tags = {
    Name = "santh-ec2-demo1"
    team = "pep-devops"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}