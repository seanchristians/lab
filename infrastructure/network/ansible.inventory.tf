locals {
  ansible_inventory = {
    wireguard_servers = { hosts = {
      "squiggle-darkened" = {
        ansible_host           = data.tailscale_device.squiggle_darkened.name
        ansible_user           = "root"
        ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
        tailscale_auth_key     = tailscale_tailnet_key.container.key
        wg_easy_service_port   = 51821
      }
    } }
  }
}

data "tailscale_device" "squiggle_darkened" {
  hostname = "squiggle-darkened"
}
