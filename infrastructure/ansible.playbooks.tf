resource "terraform_data" "ansible_playbook_run" {
  for_each = terraform_data.ansible_playbook_diff_id

  triggers_replace = each.value.output

  provisioner "local-exec" {
    environment = {
      PLAYBOOK = each.key
    }
    command = "ansible-playbook \"$PLAYBOOK\""
  }
}

output "ansible_playbook_diff_id" {
  value = { for key, value in terraform_data.ansible_playbook_diff_id : key => value.output }
}

resource "terraform_data" "ansible_playbook_diff_id" {
  for_each = data.local_command.ansible_playbook_diff

  input = each.value.stdout ? uuid() : try(data.terraform_remote_state.this.outputs.ansible_playbook_diff_id[each.key], uuid())
}

data "local_command" "ansible_playbook_diff" {
  for_each  = local.ansible_playbooks
  command   = "/bin/bash"
  arguments = ["-c", "ANSIBLE_STDOUT_CALLBACK=ansible.posix.json ansible-playbook ${each.key} --check --diff | jq -j '[.plays[].tasks[].hosts | map(.changed)] | flatten | any(.)'"]
}

locals {
  ansible_playbooks = toset(compact(split("\n", data.local_command.ansible_playbooks.stdout)))
}

data "local_command" "ansible_playbooks" {
  command   = "find"
  arguments = ["playbooks", "-name", "*.yml", "-o", "-name", "*.yaml"]
}
