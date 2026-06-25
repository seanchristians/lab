resource "tailscale_dns_configuration" "default" {
  magic_dns          = true
  override_local_dns = true

  dynamic "nameservers" {
    for_each = flatten(values(local.preferred_public_dns_servers))
    content {
      address = nameservers.value
    }
  }

  lifecycle {
    ignore_changes = [nameservers]
  }
}
