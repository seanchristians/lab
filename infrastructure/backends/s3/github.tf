resource "github_repository_environment" "terraform" {
  environment = "terraform"
  repository  = "seanchristians/lab"
}

resource "github_actions_environment_variable" "aws_assume_role_arn" {
  repository    = "seanchristians/lab"
  environment   = github_repository_environment.terraform.environment
  variable_name = "AWS_ROLE_ARN"
  value         = aws_iam_role.terraform.arn
}
