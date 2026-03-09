data "porkbun_domains" "all" {}

locals {
  porkbun_active_domain = {
    for domain in data.porkbun_domains.all.domains : domain.domain => domain
    if domain.status == "ACTIVE"
  }

  network_domain        = local.porkbun_active_domain["scchq.net"].domain
  acme_challenge_domain = local.porkbun_active_domain["sean.directory"].domain

  preferred_public_dns_servers = {
    google     = ["8.8.8.8", "8.8.4.4", "2001:4860:4860::8888", "2001:4860:4860::8844"]
    cloudflare = ["1.1.1.1", "1.0.0.1", "2606:4700:4700::1111", "2606:4700:4700::1001"]
  }
}

data "external" "module_path_in_git_repo" {
  program = ["/bin/bash", "-c", "echo -n $(git rev-parse --show-prefix) | jq -Rs '{content: .}'"]
}
