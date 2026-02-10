resource "tailscale_dns_preferences" "default" {
  magic_dns = true
}

resource "tailscale_dns_search_paths" "network" {
  search_paths = [local.domain]
}

locals {
  tailnet_dns_name = "tail18a6a8.ts.net"
  domain           = "scchq.net"
}
