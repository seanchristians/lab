variable "ansible_inventory" {
  description = "Ansible inventory"
  sensitive   = true
  nullable    = false
}

variable "playbook" {
  type        = string
  description = "Playbook file name"
  sensitive   = false
  nullable    = false
}

variable "sentinel" {
  description = "Trigger playbook re-run"
  sensitive   = false
  nullable    = true
}

locals {
  playbook_fp = "${path.module}/${var.playbook}"

  target_groups = [for run in yamldecode(data.local_file.playbook.content) : run.hosts]
}

data "local_file" "playbook" {
  filename = local.playbook_fp
}

action "ansible_playbook_run" "playbook" {
  config {
    playbooks   = [local.playbook_fp]
    inventories = [jsonencode(var.ansible_inventory)]
  }
}

resource "terraform_data" "run" {
  input = [
    sha512(jsonencode([for group in local.target_groups : var.ansible_inventory[group]])),
    var.sentinel
  ]

  lifecycle {
    action_trigger {
      actions = [action.ansible_playbook_run.playbook]
      events  = [after_create, after_update]
    }
  }
}
