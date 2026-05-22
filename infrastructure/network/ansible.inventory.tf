resource "ansible_group" "wireguard_servers" {
  name     = "wireguard_servers"
  children = [ansible_host.squiggle_darkened.id]

  lifecycle {
    replace_triggered_by = [terraform_data.playbook_wg_easy_podman]
    action_trigger {
      actions = [action.ansible_playbook_run.wg_easy_podman]
      events  = [after_create, after_update]
    }
  }
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
