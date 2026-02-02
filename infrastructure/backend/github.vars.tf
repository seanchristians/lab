locals {
  github_repo = "lab"
}

resource "github_actions_variable" "backend_aws_role" {
  repository    = local.github_repo
  variable_name = "TF_BACKEND_AWS_ROLE"
  value         = aws_iam_role.terraform.arn
}
