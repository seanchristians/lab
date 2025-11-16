terraform {
  required_providers {
    tailscale = {
      source = "tailscale/tailscale"
      version = "0.24.0"
    }
  }
}

provider "tailscale" {
  tailnet = var.tailscale_tailnet_id
  oauth_client_id = var.tailscale_oauth.client_id
  oauth_client_secret = var.tailscale_oauth.client_secret
  user_agent = "Terraform / seanchristians/lab"
}
