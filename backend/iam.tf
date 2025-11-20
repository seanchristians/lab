data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
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

data "aws_iam_policy_document" "terraform" {
  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    actions = [
      "s3:CreateBucket",
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }

  statement {
    actions = ["s3:*Object"]
    resources = [
      "arn:aws:s3:::*/*"
    ]
  }
}

resource "aws_iam_role_policy" "terraform" {
  name   = "GitHubActionsTerraformPolicy"
  policy = data.aws_iam_policy_document.terraform.json
  role   = aws_iam_role.terraform.name
}
