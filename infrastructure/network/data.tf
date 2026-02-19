data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id         = data.aws_vpc.default.id
  default_for_az = true
}

data "porkbun_domain" "network" {
  domain = "scchq.net"
}

data "porkbun_domain" "acme_challenge" {
  domain = "sean.directory"
}
