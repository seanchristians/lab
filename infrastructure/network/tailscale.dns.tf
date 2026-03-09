resource "tailscale_dns_configuration" "default" {
  magic_dns          = true
  override_local_dns = true

  dynamic "nameservers" {
    for_each = flatten(values(local.preferred_public_dns_servers))
    content {
      address = nameservers.value
    }
  }
}

resource "porkbun_dns_record" "tailnet" {
  for_each = local.tailnet_ips

  domain    = local.network_domain
  subdomain = regex("^(.+)\\.[^.]+\\.ts\\.net$", each.value.name)[0]
  type      = can(cidrnetmask("${each.key}/32")) ? "A" : "AAAA"
  content   = each.key
}

locals {
  tailnet_tags           = toset(keys(jsondecode(data.local_file.tailnet_policy.content).tagOwners))
  tailnet_tagged_devices = distinct(flatten([for tagged_devices in data.tailscale_devices.tagged_devices : tagged_devices.devices]))
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
