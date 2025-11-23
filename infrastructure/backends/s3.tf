terraform {
  backend "s3" {
    bucket       = "seanchristians-lab-terraform-state"
    key          = ""
    region       = "ca-central-1"
    use_lockfile = true
  }
}
