resource "ansible_playbook" "wg_easy_podman" {
  name     = data.tailscale_device.squiggle-darkened.hostname
  playbook = "ansible-playbooks/wg-easy.yaml"
}
