action "ansible_playbook_run" "wg_easy_podman" {
  config {
    playbooks = ["${path.cwd}/ansible-playbooks/wg-easy.yaml"]
    inventories = [data.ansible_inventory.all_hosts.json]
  }
}
