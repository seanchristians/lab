locals {
  preferred_public_dns_servers = {
    google     = ["8.8.8.8", "8.8.4.4", "2001:4860:4860::8888", "2001:4860:4860::8844"]
    cloudflare = ["1.1.1.1", "1.0.0.1", "2606:4700:4700::1111", "2606:4700:4700::1001"]
  }
}

data "external" "module_path_in_git_repo" {
  program = ["/bin/bash", "-c", "echo -n $(git rev-parse --show-prefix) | jq -Rs '{content: .}'"]
}

data "porkbun_domains" "all" {}

# Triggers all tokens to be regenerated
# Add 'lifecycle {replace_triggered_by = [terraform_data.api_token_sentinel]}' to new token-generating resources
resource "terraform_data" "api_token_sentinel" {
  triggers_replace = "4D599A79-327C-49EB-815D-092219AFCA38"
}

variable "dns_proxy_domain" {
  type        = string
  description = "Domain used for deSEC.io for use with Dynamic DNS-enabled servers"
  validation {
    condition     = contains(data.porkbun_domains.all.domains[*].domain, var.dns_proxy_domain)
    error_message = "Domain is not registered in Porkbun"
  }
  const = true
}

variable "ddns_servers" {
  type = map(object({
    alias_domains = list(string)
  }))
  description = <<-DESC
  Servers enabled for DDNS. The key must be a name that SSH can resolve and connect to,
  ie. user@server.example.com or a name set in the SSH config.
  The ddns domain will be mapped to the alias domains with CNAME or ALIAS records, as appropriate.
  DESC
  nullable    = true
  default     = {}
}

variable "backend_s3_bucket" {
  type        = string
  description = "S3 bucket where the backend is stored."
}
