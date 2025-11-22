terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.24.0"
    }
  }
}

provider "tailscale" {
  user_agent          = "Terraform / seanchristians/lab"
}
