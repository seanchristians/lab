data "tailscale_device" "ansible_host" {
  for_each = toset(keys(var.ansible_hosts))
  hostname = each.key
}

locals {
  ansible_inventory = { for group, group_data in var.ansible_groups : group => merge(group_data, {
    "hosts" = { for host, host_data in local.ansible_hosts_with_fqdn : host => host_data
    if contains(keys(group_data.hosts), host) }
  }) }

  ansible_hosts_with_fqdn = { for host, data in var.ansible_hosts : host => merge({
    ansible_host = data.tailscale_device.ansible_host[host].name
  }, data) }
}

ephemeral "local_command" "ansible_inventory" {
  command = "tee"
  stdin   = local.ansible_inventory
}
