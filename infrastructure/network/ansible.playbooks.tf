resource "terraform_data" "ansible_playbook" {
  for_each = var.ansible_playbooks

  input = flatten([
    each.value.sentinel,
    data.local_file.ansible_playbook[each.key].id
    ], [
    for group in each.value.ansible_groups : local.ansible_inventory[group]
  ])

  lifecycle {
    action_trigger {
      actions = [action.ansible_playbook_run.ansible_playbook[each.key]]
      events  = [after_create, after_update]
    }
  }
}

action "ansible_playbook_run" "ansible_playbook" {
  for_each = keys(var.ansible_playbooks)

  config {
    playbooks   = ["ansible-playbooks/${each.value}.yaml"]
    inventories = [local.ansible_inventory_encoded]
  }
}

data "local_file" "ansible_playbook" {
  for_each = keys(var.ansible_playbooks)

  filename = "ansible-playbooks/${each.value}.yaml"
}
