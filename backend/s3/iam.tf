resource "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["${var.github_repository}:*"]
    }
  }
}

resource "aws_iam_role" "terraform" {
  name               = var.github_actions_terraform_role_name
  description        = "Terraform in github.com/${var.github_repository}"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
}

resource "aws_iam_role_policy_attachment" "terraform_iam" {
  role       = aws_iam_role.terraform.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

data "aws_iam_policy_document" "terraform_s3" {
  statement {
    actions   = ["s3:*"]
    resources = [
      aws_s3_bucket.terraform_state.arn,
      "${aws_s3_bucket.terraform_state.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "terraform_s3" {
  name   = "terraform-s3"
  policy = data.aws_iam_policy_document.terraform_s3.json
  role   = aws_iam_role.terraform.name
}

output "terraform_iam_role_arn" {
  value = aws_iam_role.terraform.arn
}
