action "ansible_playbook_run" "wg_easy_podman" {
  config {
    playbooks   = [local.ansible_playbooks.wg_easy_podman]
    inventories = [data.ansible_inventory.primary.json]
  }
}

resource "terraform_data" "playbook_wg_easy_podman" {
  input = "ECF964FD-0829-41F1-8F6B-703960297624" # Sentinel value to manually trigger action

  triggers_replace = [
    data.local_file.playbook_wg_easy_podman.id,
    data.ansible_inventory.primary.json
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
