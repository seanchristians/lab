resource "tailscale_dns_preferences" "default" {
  magic_dns = false
}

locals {
  tailnet_tagged_ips = flatten([
    for device in data.tailscale_devices.tagged_devices.devices : [
      for address in device.addresses : {
        ip      = address
        is_ipv4 = can(cidrnetmask("${address}/32"))
        name    = join(".", slice(split(".", device.name), 0, length(split(".", device.name)) - 3))
      }
    ]
  ])

  tailnet_tags = keys(jsondecode(data.local_file.tailnet_policy.content).tagOwners)
}

output "tailnet_devices" {
  value = jsonencode(data.tailscale_devices.tagged_devices.devices)
}

data "tailscale_devices" "tagged_devices" {
  filter {
    name   = "isEphemeral"
    values = ["false"]
  }

  filter {
    name   = "tags"
    values = "tag:home"
  }
}

resource "porkbun_dns_record" "tailnet" {
  for_each = tomap({ for device in local.tailnet_tagged_ips : device.ip => device })

  domain    = data.porkbun_domain.network.domain
  subdomain = each.value.name
  type      = each.value.is_ipv4 ? "A" : "AAAA"
  content   = each.key
}
