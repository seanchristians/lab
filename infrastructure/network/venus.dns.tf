data "tailscale_device" "venus" {
  hostname = split(".", aws_instance.venus.private_dns)[0]

  depends_on = [tailscale_dns_preferences.default]
}

resource "porkbun_dns_record" "venus" {
  domain    = data.porkbun_domain.network.domain
  subdomain = "venus"
  type      = "CNAME"
  content   = data.tailscale_device.venus.name
}
