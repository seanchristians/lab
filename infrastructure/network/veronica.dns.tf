data "tailscale_device" "veronica" {
  hostname = "veronica"
}

resource "terraform_data" "tailscale_device_veronica" {
  input = data.tailscale_device.veronica.name

  depends_on = [tailscale_dns_preferences.default]
}

resource "porkbun_dns_record" "veronica" {
  domain    = data.porkbun_domain.network.domain
  subdomain = "veronica"
  type      = "CNAME"
  content   = terraform_data.tailscale_device_veronica.output
}
