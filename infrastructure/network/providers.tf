terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.26.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.30.0"
    }
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "1.3.1"
    }
    gcore = {
      source  = "G-Core/gcore"
      version = "0.32.8"
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

provider "porkbun" {
  max_retries = 5
}

provider "gcore" {}
