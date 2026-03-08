terraform {
  backend "s3" {
    bucket       = ""
    key          = "infrastructure/network/terraform.tfstate"
    region       = ""
    use_lockfile = true
  }
}
