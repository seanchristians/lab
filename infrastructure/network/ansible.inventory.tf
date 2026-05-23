locals {
  ansible_inventory = {
    wireguard_servers = { hosts = {
      "squiggle-darkened" = {
        ansible_host           = data.tailscale_device.squiggle_darkened.name
        ansible_user           = "root"
        ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
        wireguard_admin_ports = concat([
          for ip in data.tailscale_device.squiggle_darkened.addresses : "${ip}:51821:51821/tcp"
          if can(cidrnetmask("${ip}/32"))
          ], [
          for ip in data.tailscale_device.squiggle_darkened.addresses : "[${ip}]:51821:51821/tcp"
          if !can(cidrnetmask("${ip}/32"))
        ])
      }
    } }
  }
}

data "tailscale_device" "squiggle_darkened" {
  hostname = "squiggle-darkened"
}
