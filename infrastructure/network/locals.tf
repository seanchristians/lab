data "porkbun_domains" "all" {}

locals {
  porkbun_active_domain = {
    for domain in data.porkbun_domains.all.domains : domain.domain => domain
    if domain.status == "ACTIVE"
  }

  network_domain        = local.porkbun_active_domain["scchq.net"].domain
  acme_challenge_domain = local.porkbun_active_domain["sean.directory"].domain
}

data "external" "module_path_in_git_repo" {
  program = ["/bin/bash", "-c", "echo -n $(git rev-parse --show-prefix) | jq -Rs '{content: .}'"]
}
