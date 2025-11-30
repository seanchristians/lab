resource "aws_instance" "venus" {
  ami                 = "ami-0c9146af31980eb75"
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

resource "aws_ebs_volume" "venus" {
  availability_zone = aws_default_subnet.cac1-az4.availability_zone
  encrypted         = true
  size              = "8"
  type              = "gp3"
  iops              = "3000"
  throughput        = "125"
}

import {
  to = aws_instance.venus
  id = "i-03250ab66e443ceba"
}

import {
  to = aws_ebs_volume.venus
  id = "vol-086f93c1a420c9722"
}
