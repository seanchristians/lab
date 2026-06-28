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
  for_each   = toset(try(var.ansible_groups["minecraft_servers"]), [])
  playbook   = "playbooks/minecraft.yaml"
  name       = data.tailscale_device.ansible_host[each.key].name
  replayable = false

  extra_vars = try(var.ansible_hosts[each.key], null)

  lifecycle {
    replace_triggered_by = [terraform_data.minecraft_playbook]
  }
}

resource "terraform_data" "minecraft_playbook" {
  triggers_replace = data.local_file.minecraft_playbook.id
}

data "local_file" "minecraft_playbook" {
  filename = "./playbooks/minecraft.yaml"
}

data "tailscale_device" "ansible_host" {
  for_each = keys(var.ansible_hosts)
  hostname = each.key
}
