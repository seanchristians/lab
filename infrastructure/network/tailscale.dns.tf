resource "tailscale_dns_preferences" "default" {
  magic_dns = false
}

resource "porkbun_dns_record" "tailnet" {
  for_each = local.tailnet_ips

  domain    = local.network_domain
  subdomain = each.value.name
  type      = can(cidrnetmask("${each.key}/32")) ? "A" : "AAAA"
  content   = each.key
}

locals {
  tailnet_tags           = toset(keys(jsondecode(data.local_file.tailnet_policy.content).tagOwners))
  tailnet_tagged_devices = toset(flatten(data.tailscale_devices.tagged_devices[*].devices))
  tailnet_ips            = merge([for device in local.tailnet_tagged_devices : { for address in device.addresses : address => device }]...)
}

data "tailscale_devices" "tagged_devices" {
  for_each = local.tailnet_tags

  filter {
    name   = "isEphemeral"
    values = ["false"]
  }

  filter {
    name   = "tags"
    values = [each.key]
  }
}
