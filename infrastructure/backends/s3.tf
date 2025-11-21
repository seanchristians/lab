terraform {
  backend "s3" {
    bucket       = "terraform-state"
    key          = ""
    region       = ""
    use_lockfile = true
    assume_role_with_web_identity = {
      role_arn = ""
      web_identity_token = ""
    }
  }
}
