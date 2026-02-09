data "tailscale_device" "venus" {
  hostname = "venus"
}

resource "porkbun_dns_record" "venus" {
  domain    = data.porkbun_domain.network.domain
  subdomain = "venus"
  type      = "CNAME"
  content   = data.tailscale_device.venus.name
}
