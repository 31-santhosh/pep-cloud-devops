resource "aws_instance" "testec2" {
  ami           = "ami-0b6d9d3d33ba97d99"
  subnet_id = aws_subnet.subdemo-pub.id
  instance_type = "t3.micro"
  key_name      = "webserver1"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "santh-ec2-demo1"
    team = "pep-devops"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpcdemo.id

  tags = {
    Name = "testsg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}