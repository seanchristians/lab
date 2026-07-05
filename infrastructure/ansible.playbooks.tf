data "local_command" "ansible_playbook_run" {
  for_each  = { for playbook, diff in data.local_command.ansible_playbook_diff : playbook => diff if diff.stdout && terraform.applying }
  command   = "ansible-playbook"
  arguments = [each.key]
}

data "local_command" "ansible_playbook_diff" {
  for_each  = local.ansible_playbooks
  command   = "/bin/bash"
  arguments = ["-c", "ANSIBLE_STDOUT_CALLBACK=ansible.posix.json ansible-playbook ${each.key} --check --diff | jq -r '[.plays[].tasks[].hosts | map(.changed)] | flatten | any(.)'"]
}

locals {
  ansible_playbooks = toset(compact(split("\n", data.local_command.ansible_playbooks.stdout)))
}

data "local_command" "ansible_playbooks" {
  command   = "find"
  arguments = ["playbooks", "-name", "*.yml", "-o", "-name", "*.yaml"]
}
