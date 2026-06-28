resource "ansible_playbook" "minecraft_server" {
  for_each   = toset(try(var.ansible_groups["minecraft_servers"], []))
  playbook   = "playbooks/minecraft.yaml"
  name       = data.tailscale_device.ansible_host[each.key].name
  replayable = false
  verbosity  = 5

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
  for_each = toset(keys(var.ansible_hosts))
  hostname = each.key
}
