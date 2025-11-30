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

resource "aws_ebs_volume" "venus" {
  availability_zone = aws_default_subnet.cac1-az4.availability_zone
  encrypted         = true
  size              = "8"
  type              = "gp3"
  iops              = "3000"
  throughput        = "125"
}

resource "aws_volume_attachment" "venus" {
  instance_id = aws_instance.venus.id
  volume_id   = aws_ebs_volume.venus.id
  device_name = "/dev/xvda"
}

import {
  to = aws_instance.venus
  id = "i-03250ab66e443ceba"
}

import {
  to = aws_ebs_volume.venus
  id = "vol-086f93c1a420c9722"
}
