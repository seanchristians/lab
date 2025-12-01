data "aws_vpc" "default_ca_central_1" {
  default = true
}

data "aws_subnet" "default_cac1_az4" {
  vpc_id         = data.aws_vpc.default_ca_central_1.id
  default_for_az = true
}
