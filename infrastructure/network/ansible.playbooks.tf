resource "ansible_playbook" "wg_easy_podman" {
  name       = ansible_host.squiggle_darkened.name
  playbook   = "ansible-playbooks/wg-easy.yaml"
  replayable = false

  lifecycle {
    replace_triggered_by = [
      data.local_file.playbook_wg_easy_podman,
      ansible_host.squiggle_darkened
    ]
  }
}

data "local_file" "playbook_wg_easy_podman" {
  filename = "ansible-playbooks/wg-easy.yaml"
}
