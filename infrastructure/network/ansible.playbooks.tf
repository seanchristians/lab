action "ansible_playbook_run" "wg_easy_podman" {
  config {
    playbooks       = [local.ansible_playbooks.wg_easy_podman]
    inventory_files = ["ansible-inventory.yaml"]
  }
}

resource "terraform_data" "playbook_wg_easy_podman" {
  triggers_replace = data.local_file.playbook_wg_easy_podman.id
}

data "local_file" "playbook_wg_easy_podman" {
  filename = local.ansible_playbooks.wg_easy_podman
}
