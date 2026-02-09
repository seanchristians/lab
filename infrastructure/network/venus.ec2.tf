resource "aws_instance" "venus" {
  ami                 = "ami-0c096d78166072826"
  instance_type       = "t4g.nano"
  enable_primary_ipv6 = true

  vpc_security_group_ids = [
    aws_security_group.venus.id
  ]

  tags = {
    Name = "Venus"
  }
}
