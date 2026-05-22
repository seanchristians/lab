resource "ansible_host" "squiggle_darkened" {
  name   = data.tailscale_device.squiggle_darkened.name
  groups = ["wireguard_servers"]
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
