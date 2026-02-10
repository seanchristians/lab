locals {
  tailnet_dns_name = "tail18a6a8.ts.net"
  domain           = "scchq.net"
}

data "tailscale_device" "this" {
  hostname = var.tailnet_hostname
}

resource "porkbun_dns_record" "this" {
  domain    = local.domain
  subdomain = var.subdomain
  type      = "CNAME"
  content   = "${data.tailscale_device.this.hostname}.${local.tailnet_dns_name}"
}
