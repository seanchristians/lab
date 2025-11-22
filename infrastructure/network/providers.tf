terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.24.0"
    }
  }
}

provider "tailscale" {
  tailnet             = var.tailscale_tailnet_id
  user_agent          = "Terraform / seanchristians/lab"
}
