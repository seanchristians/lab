data "tailscale_device" "veronica" {
  hostname = "veronica"

  depends_on = [tailscale_dns_preferences.default]
}

resource "porkbun_dns_record" "veronica" {
  domain    = data.porkbun_domain.network.domain
  subdomain = "veronica"
  type      = "CNAME"
  content   = data.tailscale_device.veronica.name
}
