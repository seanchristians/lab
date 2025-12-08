terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "2.39.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "tls" {}
