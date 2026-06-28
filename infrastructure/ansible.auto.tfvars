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
  }
}

ansible_hosts = {
  "squiggle-darkened" = {
    ansible_user = "core"
  }
}
