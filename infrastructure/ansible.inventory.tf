locals {
  ansible_inventory = { for group, group_data in var.ansible_groups : group => merge(group_data,
    try(local.ansible_group_data[group], {}),
    {
      "hosts" = { for host, host_data in var.ansible_hosts : host => merge({
        ansible_host = data.tailscale_device.ansible_host[host].name
        }, host_data)
      if contains(group_data.hosts, host) }
  }) }

  ansible_group_data = {
    ddns = {
      desec_domain = local.dns_proxy_domain
      subdomain    = local.minecraft_server_vpn_subdomain
      desec_token  = terraform_data.minecraft_vpn_domain_desec_token.store.sensitive_output
    }
  }
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
