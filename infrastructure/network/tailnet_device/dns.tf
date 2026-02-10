locals {
  domain = "scchq.net"
}

data "tailscale_device" "this" {
  hostname = var.tailnet_hostname
}

resource "porkbun_dns_record" "this" {
  for_each = toset(data.tailscale_device.this.addresses)

  domain    = local.domain
  subdomain = var.subdomain
  type      = can(cidrnetmask("${each.key}/32")) ? "A" : "AAAA"
  content   = each.key
}
