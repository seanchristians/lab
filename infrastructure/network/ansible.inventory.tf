locals {
  ansible_inventory_encoded = jsonencode(local.ansible_inventory)
  ansible_inventory = sensitive({ for group, hosts in local.ansible_groups : group => { "hosts" = {
    for host in hosts : host => local.ansible_hosts[host]
  } } })

  ansible_groups = {
    wireguard_servers = ["squiggle-darkened"],
    ddns              = ["squiggle-darkened"],
    minecraft_servers = ["squiggle-darkened"]
  }

  ansible_hosts = {
    "squiggle-darkened" = {
      ansible_host           = data.tailscale_device.squiggle_darkened.name
      ansible_user           = "core"
      ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
      wireguard_domain       = "${local.minecraft_server_vpn_subdomain}.${desec_domain.dns_proxy.name}"
      wireguard_dns          = "149.112.121.10,149.112.122.10,2620:10A:80BB::10,2620:10A:80BC::10" # CIRA Canadian Shield
      wireguard_ipv4_cidr    = "172.30.0.0/24"
      wireguard_ipv6_cidr    = "fdef:aced::/64"
      desec_domain           = "${local.minecraft_server_vpn_subdomain}.${desec_domain.dns_proxy.name}"
      desec_token            = terraform_data.minecraft_vpn_domain_desec_token.store.sensitive_output
      tailscale_auth_key     = tailscale_tailnet_key.container.key
      tailnet_service        = tailscale_service.minecraft.id
    }
  }
}

data "tailscale_device" "squiggle_darkened" {
  hostname = "squiggle-darkened"
}

resource "ansible_group" "minecraft_servers" {
  name     = "minecraft_servers"
  children = [ansible_host.squiggle_darkened.id]
}

resource "ansible_host" "squiggle_darkened" {
  name = "squiggle-darkened"
  variables = {
    ansible_host           = data.tailscale_device.squiggle_darkened.name
    ansible_user           = "core"
    ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
  }
}
