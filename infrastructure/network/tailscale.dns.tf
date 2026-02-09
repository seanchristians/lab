resource "tailscale_dns_configuration" "default" {
  magic_dns    = true
  search_paths = data.porkbun_domain.network
}
