terraform {
  backend "s3" {
    bucket       = "seanchristians-lab-terraform-state"
    key          = "github/terraform.tfstate"
    region       = "ca-central-1"
    use_lockfile = true
  }
}
