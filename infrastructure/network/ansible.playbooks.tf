resource "ansible_playbook" "wg_easy_podman" {
  name     = data.tailscale_device.squiggle_darkened.name
  playbook = "ansible-playbooks/wg-easy.yaml"
}
