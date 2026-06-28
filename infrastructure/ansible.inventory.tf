locals {
  ansible_inventory = { for group, group_data in var.ansible_groups : group => merge(group_data, {
    "hosts" = { for host, host_data in var.ansible_hosts : host => merge({
      ansible_host = data.tailscale_device.ansible_host[host].name
      }, host_data)
    if contains(group_data.hosts, host) }
  }) }
}

ephemeral "local_command" "ansible_inventory" {
  command   = "tee"
  arguments = ["inventory.yaml"]
  stdin     = yamlencode(local.ansible_inventory)
}

data "tailscale_device" "ansible_host" {
  for_each = toset(keys(var.ansible_hosts))
  hostname = each.key
}
