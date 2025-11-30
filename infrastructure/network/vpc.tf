resource "aws_default_vpc" "ca-central-1" {
  assign_generated_ipv6_cidr_block = true
}

resource "aws_default_subnet" "cac1-az4" {
  availability_zone               = "ca-central-1d"
  ipv6_native                     = true
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = false
}
