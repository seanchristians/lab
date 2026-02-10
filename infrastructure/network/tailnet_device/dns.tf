locals {
  domain = "scchq.net"
}

data "tailscale_device" "this" {
  hostname = var.tailnet_hostname
}

resource "porkbun_dns_record" "ipv4" {
  domain    = local.domain
  subdomain = var.subdomain
  type      = "A"
  content   = data.tailscale_device.this.addresses
}

moved {
  from = porkbun_dns_record.this
  to   = porkbun_dns_record.ipv4
}
