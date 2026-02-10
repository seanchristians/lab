resource "tailscale_dns_preferences" "default" {
  magic_dns = false
}

data "tailscale_devices" "tailnet" {}

locals {
  tailnet_tagged_ips = flatten([
    for device in data.tailscale_devices.tailnet.devices : [
      for address in device.addresses : {
        device  = device.hostname
        ip      = address
        is_ipv4 = can(cidrnetmask("${address}/32"))
      } if length(device.tags) > 0
    ]
  ])
}

# resource "porkbun_dns_record" "tailnet" {
#   for_each = []

#   domain    = local.domain
#   subdomain = var.subdomain
#   type      = can(cidrnetmask("${each.key}/32")) ? "A" : "AAAA"
#   content   = each.key
# }
