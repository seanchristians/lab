locals {
  preferred_public_dns_servers = {
    google     = ["8.8.8.8", "8.8.4.4", "2001:4860:4860::8888", "2001:4860:4860::8844"]
    cloudflare = ["1.1.1.1", "1.0.0.1", "2606:4700:4700::1111", "2606:4700:4700::1001"]
  }

  domain_canada    = "seanchristians.ca"
  dns_proxy_domain = "sean.directory"
}

data "external" "module_path_in_git_repo" {
  program = ["/bin/bash", "-c", "echo -n $(git rev-parse --show-prefix) | jq -Rs '{content: .}'"]
}

# Triggers all tokens to be regenerated
# Add 'lifecycle {replace_triggered_by = [terraform_data.api_token_sentinel]}' to new token-generating resources
resource "terraform_data" "api_token_sentinel" {
  triggers_replace = "D4417820-CD58-42B8-BADA-08F62DE2E9AD"
}

variable "ddns_servers" {
  type = map(object({
    alias_domains = list(string)
  }))
  description = "Servers enabled for DDNS.
    The key must be a name that SSH can resolve and connect to, ie. user@server.example.com or a name set in the SSH config.
    The ddns domain will be mapped to the alias domains with CNAME or ALIAS records, as appropriate"
  nullable    = true
  default     = []
}
