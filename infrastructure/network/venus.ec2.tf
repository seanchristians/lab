resource "aws_instance" "venus" {
  ami                 = "ami-0c096d78166072826"
  instance_type       = "t4g.nano"
  availability_zone   = aws_default_subnet.cac1-az4.availability_zone
  enable_primary_ipv6 = true

  vpc_security_group_ids = [
    aws_security_group.venus.id
  ]

  tags = {
    Name = "Venus"
  }
}

import {
  to = aws_instance.venus
  id = "i-03250ab66e443ceba"
}
