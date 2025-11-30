resource "aws_instance" "venus" {
  instance_type = "t4g.nano"
}

import {
  to = aws_instance.venus
  id = "i-03250ab66e443ceba"
}
