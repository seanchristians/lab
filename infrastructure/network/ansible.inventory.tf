resource "ansible_group" "wireguard_servers" {
  name     = "wireguard_servers"
  children = [ansible_host.squiggle_darkened.name]
}

resource "ansible_host" "squiggle_darkened" {
  name = data.tailscale_device.squiggle_darkened.name

  variables = {
    wireguard_admin_ports = concat(
      [for ip in data.tailscale_device.squiggle_darkened.addresses : "${ip}:51821:51821/tcp"
      if can(cidrnetmask("${ip}/32"))], # ipv4
      [for ip in data.tailscale_device.squiggle_darkened.addresses : "[${ip}]:51821:51821/tcp"
      if !can(cidrnetmask("${ip}/32"))] # escape ipv6 in []
    )
  }
}

data "tailscale_device" "squiggle_darkened" {
  hostname = "squiggle-darkened"
}
