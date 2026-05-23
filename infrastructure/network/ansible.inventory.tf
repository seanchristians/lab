locals {
  ansible_inventory = {
    wireguard_servers = { hosts = {
      "squiggle-darkened" = {
        ansible_host           = data.tailscale_device.squiggle_darkened.name
        ansible_user           = "root"
        ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
        test_variable          = "foo"
      }
    } }
  }
}

data "tailscale_device" "squiggle_darkened" {
  hostname = "squiggle-darkened"
}
