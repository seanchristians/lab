data "aws_iam_policy_document" "github_actions_assume_role" {

}

data "aws_iam_policy_document" "terraform" {

}

resource "aws_iam_role" "terraform" {
  name               = "GitHubActionsTerraformRole"
  description        = "Terraform in github.com/seanchristians/lab"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
}

resource "aws_iam_policy" "terraform" {
  name   = "GitHubActionsTerraformPolicy"
  policy = data.aws_iam_policy_document.terraform.json
}

resource "aws_iam_role_policy_attachment" "terraform" {
  role       = aws_iam_role.terraform.name
  policy_arn = aws_iam_policy.terraform.arn
}
