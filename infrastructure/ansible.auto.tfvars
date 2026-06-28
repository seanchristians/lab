ansible_groups = {
  minecraft_servers = {
    hosts = [
      "squiggle-darkened"
    ]
  }

  ddns = {
    hosts = [
      "squiggle-darkened"
    ]
    vars = {
      desec_domain = "sean.directory"
    }
  }
}

ansible_hosts = {
  "squiggle-darkened" = {
    ansible_user = "core"
  }
}
