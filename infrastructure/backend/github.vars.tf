locals {
  github_repo = "lab"
}

resource "github_actions_variable" "backend_aws_bucket" {
  repository    = local.github_repo
  variable_name = "TF_BACKEND_AWS_BUCKET"
  value         = aws_s3_bucket.terraform_state.bucket
}

resource "github_actions_variable" "backend_aws_region" {
  repository    = local.github_repo
  variable_name = "TF_BACKEND_AWS_REGION"
  value         = aws_s3_bucket.terraform_state.bucket_region
}

resource "github_actions_variable" "backend_aws_role" {
  repository    = local.github_repo
  variable_name = "TF_BACKEND_AWS_ROLE"
  value         = aws_iam_role.terraform.arn
}
