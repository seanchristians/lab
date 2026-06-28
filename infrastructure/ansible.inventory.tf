data "tailscale_device" "ansible_host" {
  for_each = toset(keys(var.ansible_hosts))
  hostname = each.key
}

locals {
  ansible_inventory = yamlencode({ for group in var.ansible_groups : group => { "hosts" = {
    for host in var.ansible_groups[group] : host => merge(
      try(var.ansible_hosts[host], {}), {
        ansible_host = data.tailscale_device.ansible_host[host].name
      }
    )
  } } })
}

ephemeral "local_command" "ansible_inventory" {
  command = "tee"
  stdin   = local.ansible_inventory
}
