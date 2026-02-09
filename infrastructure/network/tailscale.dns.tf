resource "tailscale_dns_preferences" "default" {
  magic_dns = true
}

resource "tailscale_dns_search_paths" "network" {
  search_paths = [data.porkbun_domain.network]
}
