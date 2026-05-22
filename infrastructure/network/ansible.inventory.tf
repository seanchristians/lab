resource "ansible_host" "squiggle_darkened" {
  name   = data.tailscale_device.squiggle_darkened.name
  groups = ["wireguard_servers"]
  variables = {
    wireguard_admin_ports = [for ip in data.tailscale_device.squiggle_darkened.addresses : "${ip}:51821:51821/tcp"]
  }
}

data "tailscale_device" "squiggle_darkened" {
  hostname = "squiggle-darkened"
}
