action "ansible_playbook_run" "wg_easy_podman" {
  config {
    playbooks   = [data.local_file.playbook_wg_easy_podman.filename]
    inventories = [data.ansible_inventory.primary.json]
  }
}

resource "terraform_data" "wireguard_server" {
  triggers_replace = [
    data.local_file.playbook_wg_easy_podman,
    data.ansible_inventory.primary
  ]

  lifecycle {
    action_trigger {
      events  = [after_create, after_update]
      actions = [action.ansible_playbook_run.wg_easy_podman]
    }
  }
}

locals {
  wireguard_server_hostnames = [
    "squiggle-darkened"
  ]
}

data "local_file" "playbook_wg_easy_podman" {
  filename = "ansible-playbooks/wg-easy.yaml"
}

data "ansible_inventory" "primary" {
  group {
    name = "wireguard_servers"

    dynamic "host" {
      for_each = toset([
        for device in data.tailscale_devices.all.devices : device.name
        if contains(local.wireguard_server_hostnames, device.hostname)
      ])
      content {
        name = host.value
      }
    }
  }
}

data "tailscale_devices" "all" {}
