locals {
  ansible_inventory = { for group, group_data in var.ansible_groups : group => merge(group_data,
    {
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

  depends_on = [ephemeral.local_command.ansible_group_ddns_vars]
}

data "tailscale_device" "ansible_host" {
  for_each = toset(keys(var.ansible_hosts))
  hostname = each.key
}

ephemeral "local_command" "ansible_vars_folders" {
  command   = "mkdir"
  arguments = ["-p", "group_vars", "host_vars"]
}

ephemeral "local_command" "ansible_group_ddns_vars" {
  command   = "tee"
  arguments = ["group_vars/ddns.yaml"]
  stdin = yamlencode({
    desec_domain = local.dns_proxy_domain
  })

  depends_on = [ephemeral.local_command.ansible_vars_folders]
}
