resource "ansible_group" "minecraft_servers" {
  name = "minecraft_servers"
}

resource "ansible_group" "ddns" {
  name = "ddns"

  variables = {
    desec_domain = desec_domain.dns_proxy.name
  }
}

resource "ansible_host" "squiggle_darkened" {
  name = "squiggle-darkened"

  groups = [
    ansible_group.minecraft_servers.id,
    ansible_group.ddns.id
  ]

  variables = {
    ansible_host           = data.tailscale_device.squiggle_darkened.name
    ansible_user           = "core"
    ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
    subdomain              = local.minecraft_server_vpn_subdomain
    desec_token            = terraform_data.minecraft_vpn_domain_desec_token.store.sensitive_output
  }
}

resource "ansible_playbook" "minecraft_server" {
  for_each   = { for device in data.tailscale_devices.minecraft_servers.devices : device.id => device }
  playbook   = "playbooks/minecraft.yaml"
  name       = each.value.name
  replayable = false

  extra_vars = try(var.tailnet_servers[each.key], null)
}

data "tailscale_devices" "minecraft_servers" {
  filter {
    name  = "tags"
    value = ["tag:minecraft_server"]
  }
}
