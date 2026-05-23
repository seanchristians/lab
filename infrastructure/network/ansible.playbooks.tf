action "ansible_playbook_run" "wg_easy_podman" {
  config {
    playbooks   = [local.ansible_playbooks.wg_easy_podman]
    inventories = [jsonencode(local.ansible_inventory)]
  }
}

resource "terraform_data" "playbook_wg_easy_podman" {
  input = [
    "ECF964FD-0829-41F1-8F6B-703960297624", # Sentinel value to manually trigger action
    data.local_file.playbook_wg_easy_podman.id,
    sha512(local.ansible_inventory.wireguard_servers)
  ]

  lifecycle {
    action_trigger {
      actions = [action.ansible_playbook_run.wg_easy_podman]
      events  = [after_create, after_update]
    }
  }
}

data "local_file" "playbook_wg_easy_podman" {
  filename = local.ansible_playbooks.wg_easy_podman
}
