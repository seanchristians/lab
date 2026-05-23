# Due to limitations in the Ansible provider's implementation of their action,
# Each action must be hard-coded instead of using for_each
# See here for details:
# https://github.com/ansible/terraform-provider-ansible/issues/154

action "ansible_playbook_run" "wg_easy" {
  config {
    playbooks   = ["ansible-playbooks/wg-easy.yaml"]
    inventories = [local.ansible_inventory_encoded]
  }
}

action "ansible_playbook_run" "ddclient" {
  config {
    playbooks   = ["ansible-playbooks/ddclient.yaml"]
    inventories = [local.ansible_inventory_encoded]
  }
}

resource "terraform_data" "wg_easy_ansible_playbook" {
  input = [
    "319A3378-3724-4661-B33A-15D3EC29B57E",
    data.local_file.wg_easy_ansible_playbook.id,
    local.ansible_inventory["wireguard_servers"]
  ]

  lifecycle {
    action_trigger {
      actions = [action.ansible_playbook_run.wg_easy]
      events  = [after_create, after_update]
    }
  }
}

# resource "terraform_data" "ddclient_ansible_playbook" {
#   input = [
#     "319A3378-3724-4661-B33A-15D3EC29B57E",
#     data.local_file.ddclient_ansible_playbook.id,
#     local.ansible_inventory["ddns"]
#   ]

#   lifecycle {
#     action_trigger {
#       actions = [action.ansible_playbook_run.ddclient]
#       events  = [after_create, after_update]
#     }
#   }
# }

data "local_file" "wg_easy_ansible_playbook" {
  filename = "ansible-playbooks/wg-easy.yaml"
}

data "local_file" "ddclient_ansible_playbook" {
  filename = "ansible-playbooks/ddclient.yaml"
}
