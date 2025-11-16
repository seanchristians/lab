terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.37.0"
    }
  }
}

provider "spacelift" {}
