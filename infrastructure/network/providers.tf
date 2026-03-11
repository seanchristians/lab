terraform {
  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = "3.5.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.5"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.7.0"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.28.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.34.0"
    }
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "1.3.1"
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
