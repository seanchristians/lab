terraform {
  backend "s3" {
    bucket       = "terraform-state"
    key          = ""
    region       = "ca-central-1"
    use_lockfile = true
    assume_role_with_web_identity = {}
  }
}
