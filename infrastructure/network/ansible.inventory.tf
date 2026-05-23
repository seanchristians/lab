data "ansible_inventory" "primary" {
  group {
    name = "wireguard_servers"

    host {
      name                   = data.tailscale_device.squiggle_darkened.name
      ansible_user           = "root"
      ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
    }
  }
}

data "tailscale_device" "squiggle_darkened" {
  hostname = "squiggle-darkened"
}
