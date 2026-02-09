resource "aws_security_group" "venus" {
  name = "Venus"
}

resource "aws_vpc_security_group_egress_rule" "venus_allow_internet_v6" {
  security_group_id = aws_security_group.venus.id

  cidr_ipv6   = "::/0"
  ip_protocol = -1
}

moved {
  from = aws_vpc_security_group_egress_rule.venus_all_all_v6
  to   = aws_vpc_security_group_egress_rule.venus_allow_internet_v6
}
