locals {
  preferred_public_dns_servers = {
    google     = ["8.8.8.8", "8.8.4.4", "2001:4860:4860::8888", "2001:4860:4860::8844"]
    cloudflare = ["1.1.1.1", "1.0.0.1", "2606:4700:4700::1111", "2606:4700:4700::1001"]
  }
}

data "external" "module_path_in_git_repo" {
  program = ["/bin/bash", "-c", "echo -n $(git rev-parse --show-prefix) | jq -Rs '{content: .}'"]
}
