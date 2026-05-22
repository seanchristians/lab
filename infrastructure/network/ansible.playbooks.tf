resource "ansible_playbook" "wg_easy_podman" {
  name       = ansible_host.squiggle_darkened.name
  playbook   = "ansible-playbooks/wg-easy.yaml"
  replayable = false

  lifecycle {
    replace_triggered_by = [
      terraform_data.playbook_wg_easy_podman,
      ansible_host.squiggle_darkened
    ]
  }
}

resource "terraform_data" "playbook_wg_easy_podman" {
  triggers_replace = data.local_file.playbook_wg_easy_podman.id
}

data "local_file" "playbook_wg_easy_podman" {
  filename = local.ansible_playbooks.wg_easy_podman
}
