terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.27.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.30.0"
    }
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "1.3.1"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "3.0.0-rc2"
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

provider "restapi" {
  headers = {
    "Authorization" = "Token ${var.desec_token}"
    "Content-Type"  = "application/json"
  }

  id_attribute          = "id"
  uri                   = "https://desec.io/api/v1"
  create_returns_object = true
  retries {
    max_retries = 5
  }
}
