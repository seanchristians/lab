data "tailscale_device" "veronica" {
  hostname = "veronica"
}

resource "porkbun_dns_record" "veronica" {
  domain    = data.porkbun_domain.scchq_net.domain
  subdomain = "veronica"
  type      = "CNAME"
  content   = data.tailscale_device.veronica.name
}
