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
      values   = ["repo:seanchristians/lab:*"]
    }
  }
}

resource "aws_iam_role" "terraform" {
  name               = "GitHubActionsTerraformRole"
  description        = "Terraform in github.com/seanchristians/lab"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
}

resource "aws_iam_role_policy_attachment" "terraform" {
  role       = aws_iam_role.terraform.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}
