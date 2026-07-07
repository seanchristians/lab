terraform {
  backend "s3" {
    bucket       = ""
    key          = "infrastructure/network/terraform.tfstate"
    use_lockfile = true
  }
}

data "terraform_remote_state" "this" {
  backend = "s3"
  config = {
    bucket = var.backend_s3_bucket
    key    = "infrastructure/network/terraform.tfstate"
  }
}
