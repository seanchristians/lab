resource "aws_security_group" "venus" {
  name   = "Venus"
  vpc_id = aws_default_vpc.ca-central-1.id
}

resource "aws_vpc_security_group_egress_rule" "venus_all_all_v6" {
  security_group_id = aws_security_group.venus.id

  cidr_ipv6   = "::/0"
  ip_protocol = -1
}
