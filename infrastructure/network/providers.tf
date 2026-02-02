terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.3.0"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.24.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}

provider "sops" {}

provider "tailscale" {
  user_agent = "Terraform / seanchristians/lab"
}

provider "aws" {
  region = "ca-central-1"

  default_tags {
    tags = {
      Managed-By = "terraform"
    }
  }
}
