resource "ansible_group" "minecraft_servers" {
  name = "minecraft_servers"
}

resource "ansible_host" "squiggle_darkened" {
  name   = "squiggle-darkened"
  groups = [ansible_group.minecraft_servers.id]
  variables = {
    ansible_host           = data.tailscale_device.squiggle_darkened.name
    ansible_user           = "core"
    ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
  }
}
