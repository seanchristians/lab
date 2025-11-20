resource "aws_s3_bucket" "terraform_state" {
  bucket        = "terraform-state"
  force_destroy = true

  depends_on = [ aws_iam_role_policy.tf_state_init_s3 ]
}
