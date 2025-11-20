# Allow Terraform to view find all buckets and create a new one if the state bucket doesn't exist

data "aws_iam_policy_document" "tf_state_init_s3" {
  statement {
    actions = [
      "s3:ListAllMyBuckets",
      "s3:CreateBucket"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "tf_state_init_s3" {
  name   = "terraform-create-s3-bucket"
  policy = data.aws_iam_policy_document.tf_state_init_s3.json
  role   = aws_iam_role.terraform.name
}
