resource "aws_instance" "venus" {
  ami                 = data.aws_ami.amazon_linux_latest.id
  instance_type       = "t4g.nano"
  subnet_id           = aws_default_subnet.cac1-az4.id
  enable_primary_ipv6 = true

  vpc_security_group_ids = [
    aws_security_group.venus.id
  ]

  tags = {
    Name = "Venus"
  }
}

data "aws_ami" "amazon_linux_latest" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "architecture"
    values = ["arm64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-*-arm64"]
  }
}

import {
  to = aws_instance.venus
  id = "i-03250ab66e443ceba"
}
