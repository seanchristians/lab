resource "terraform_data" "ansible_playbook" {
  for_each = data.local_file.ansible_playbook

  triggers_replace = [
    each.value.id,
    [for group in local.ansible_playbooks_target_groups[each.key] : base64sha512(jsonencode(local.ansible_inventory[group]))]
  ]

  provisioner "local-exec" {
    environment = {
      PLAYBOOK = each.value.filename
    }
    command = "ansible-playbook \"$PLAYBOOK\""
  }

  depends_on = [ephemeral.local_command.ansible_inventory]
}

data "local_file" "ansible_playbook" {
  for_each = local.ansible_playbooks
  filename = each.key
}

locals {
  ansible_playbooks = toset(compact(split("\n", data.local_command.ansible_playbooks.stdout)))

  ansible_playbooks_target_groups = {
    for playbook, data in data.local_file.ansible_playbook : playbook => yamldecode(data.content)[*].hosts
  }
}

data "local_command" "ansible_playbooks" {
  command   = "find"
  arguments = ["playbooks", "-name", "*.yml", "-o", "-name", "*.yaml"]
}
