terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.3.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.39.0"
    }
  }
}

provider "sops" {}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}
