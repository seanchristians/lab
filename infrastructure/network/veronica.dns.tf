data "tailscale_device" "veronica" {
  hostname = "veronica"
}

resource "porkbun_dns_record" "veronica" {
  domain    = data.porkbun_domain.network.domain
  subdomain = "veronica"
  type      = "CNAME"
  content   = "${local.tailnet_dns_name}.${data.tailscale_device.veronica.hostname}"
}
