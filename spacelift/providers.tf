terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.37.0"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.24.0"
    }
  }
}

provider "spacelift" {}

provider "tailscale" {
  tailnet             = spacelift_environment_variable.tailscale_tailnet_id.value
  oauth_client_id     = spacelift_environment_variable.tailscale_oauth_client_id.value
  oauth_client_secret = spacelift_environment_variable.tailscale_oauth_client_secret.value
  user_agent          = "Terraform / seanchristians/lab"
  scopes              = ["all"]
}
