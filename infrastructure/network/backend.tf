terraform {
  backend "s3" {
    bucket       = ""
    key          = "infrastructure/network/terraform.tfstate"
    use_lockfile = true
  }
}
