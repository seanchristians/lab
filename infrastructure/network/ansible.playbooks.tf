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

action "ansible_playbook_run" "ddns" {
  config {
    playbooks   = ["ansible-playbooks/ddns.yaml"]
    inventories = [local.ansible_inventory_encoded]
  }
}

action "ansible_playbook_run" "minecraft" {
  config {
    playbooks   = ["ansible-playbooks/minecraft.yaml"]
    inventories = [local.ansible_inventory_encoded]
  }
}

resource "terraform_data" "wg_easy_ansible_playbook" {
  store {
    input = [
      "B2086939-7E82-446A-BAF9-98FCF7F193D3",
      data.local_file.wg_easy_ansible_playbook.id,
      local.ansible_inventory["wireguard_servers"]
    ]
    sensitive = true
  }

  lifecycle {
    action_trigger {
      actions = [action.ansible_playbook_run.wg_easy]
      events  = [after_create, after_update]
    }
  }
}

resource "terraform_data" "ddns_ansible_playbook" {
  store {
    input = [
      "319A3378-3724-4661-B33A-15D3EC29B57E",
      data.local_file.ddns_ansible_playbook.id,
      local.ansible_inventory["ddns"]
    ]
    sensitive = true
  }

  lifecycle {
    action_trigger {
      actions = [action.ansible_playbook_run.ddns]
      events  = [after_create, after_update]
    }
  }
}

resource "terraform_data" "minecraft_ansible_playbook" {
  store {
    input = [
      "319A3378-3724-4661-B33A-15D3EC29B57E",
      data.local_file.minecraft_ansible_playbook.id,
      local.ansible_inventory["minecraft"]
    ]
    sensitive = true
  }

  lifecycle {
    action_trigger {
      actions = [action.ansible_playbook_run.minecraft]
      events  = [after_create, after_update]
    }
  }
}

data "local_file" "wg_easy_ansible_playbook" {
  filename = "ansible-playbooks/wg-easy.yaml"
}

data "local_file" "ddns_ansible_playbook" {
  filename = "ansible-playbooks/ddns.yaml"
}

data "local_file" "ddns_ansible_playbook" {
  filename = "ansible-playbooks/minecraft.yaml"
}
