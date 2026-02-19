resource "tailscale_dns_preferences" "default" {
  magic_dns = false
}

locals {
  tailnet_tags           = keys(jsondecode(data.local_file.tailnet_policy.content).tagOwners)
  tailnet_tagged_devices = flatten([for devices in data.tailscale_devices.tagged_device : devices.devices])

  tailnet_tagged_ips = flatten([
    for device in local.tailnet_tagged_devices : [
      for address in device.addresses : {
        ip      = address
        is_ipv4 = can(cidrnetmask("${address}/32"))
        name    = join(".", slice(split(".", device.name), 0, length(split(".", device.name)) - 3))
      }
    ]
  ])
}

data "tailscale_devices" "tagged_device" {
  for_each = toset(local.tailnet_tags)
  filter {
    name   = "isEphemeral"
    values = ["false"]
  }

  filter {
    name   = "tags"
    values = [each.key]
  }
}

resource "porkbun_dns_record" "tailnet" {
  for_each = tomap({ for device in local.tailnet_tagged_ips : device.ip => device })

  domain    = data.porkbun_domain.network.domain
  subdomain = each.value.name
  type      = each.value.is_ipv4 ? "A" : "AAAA"
  content   = each.key
}
