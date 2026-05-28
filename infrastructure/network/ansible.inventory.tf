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
