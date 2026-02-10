terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "~> 0.26.0"
    }
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "~> 1.3.1"
    }
  }
}
