terraform {
  required_version = ">= 1.16"

  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = "1.4.0"
    }
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
      version = "2.8.0"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.29.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.43.0"
    }
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "1.3.3"
    }
    desec = {
      source  = "timofurrer/desec"
      version = "0.6.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.19.1"
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

provider "desec" {}

provider "cloudflare" {}
