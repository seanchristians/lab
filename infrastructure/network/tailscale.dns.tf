resource "tailscale_dns_preferences" "default" {
  magic_dns = false
}

data "tailscale_devices" "tailnet" {}

locals {
  tailnet_tagged_ips = flatten([
    for device in data.tailscale_devices.tailnet.devices : [
      for address in device.addresses : {
        ip      = address
        is_ipv4 = can(cidrnetmask("${address}/32"))
        device  = device
      } if length(device.tags) > 0
    ]
  ])
}

resource "porkbun_dns_record" "tailnet" {
  for_each = tomap({ for device in local.tailnet_tagged_ips : device.ip => device })

  domain    = "scchq.net"
  subdomain = each.value.device.hostname
  type      = each.value.is_ipv4 ? "A" : "AAAA"
  content   = each.key
}
