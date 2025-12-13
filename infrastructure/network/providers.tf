terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.24.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
  }
}

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
