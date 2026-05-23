locals {
  preferred_public_dns_servers = {
    google     = ["8.8.8.8", "8.8.4.4", "2001:4860:4860::8888", "2001:4860:4860::8844"]
    cloudflare = ["1.1.1.1", "1.0.0.1", "2606:4700:4700::1111", "2606:4700:4700::1001"]
  }
}

data "external" "module_path_in_git_repo" {
  program = ["/bin/bash", "-c", "echo -n $(git rev-parse --show-prefix) | jq -Rs '{content: .}'"]
}

# Triggers all tokens to be regenerated
# Add 'lifecycle {replace_triggered_by = [terraform_data.api_token_sentinel]}' to new token-generating resources
resource "terraform_data" "api_token_sentinel" {
  triggers_replace = "E4A0E1B6-469F-42E9-A71A-3C9F6648DACC"
}
