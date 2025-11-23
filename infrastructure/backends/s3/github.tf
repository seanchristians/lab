data "github_user" "seanchristians" {
  username = "seanchristians"
}

resource "github_repository_environment" "terraform" {
  environment = "terraform"
  repository  = "lab"
}

resource "github_actions_environment_variable" "aws_assume_role_arn" {
  repository    = "lab"
  environment   = github_repository_environment.terraform.environment
  variable_name = "AWS_ROLE_ARN"
  value         = aws_iam_role.terraform.arn
}

resource "github_repository_environment" "development" {
  environment         = "development"
  repository          = "lab"
  can_admins_bypass   = true
  prevent_self_review = false
}

resource "github_repository_environment" "production" {
  environment         = "production"
  repository          = "lab"
  can_admins_bypass   = true
  prevent_self_review = false

  reviewers {
    users = [data.github_user.seanchristians.id]
  }
}
