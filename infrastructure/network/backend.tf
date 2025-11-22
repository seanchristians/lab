terraform {
  backend "s3" {
    bucket       = "terraform-state"
    key          = "network/terraform.tfstate"
    region       = "ca-central-1"
    use_lockfile = true
    assume_role_with_web_identity = {}
  }
}
