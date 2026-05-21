data "ansible_inventory" "minecraft_servers" {
  group {
    name = "minecraft_servers"

    host {
      name         = data.tailscale_device.squiggle-darkened.hostname
      ansible_user = "root"
    }
  }
}
