variable "domain" {
  description = "apex domain (excluding any subdomain)"
  type        = string

  validation {
    condition     = contains([for domain in data.porkbun_domains.account.domains : domain.domain], var.domain)
    error_message = "domain ${var.domain} doesn't exist in your Porkbun account or API access is not enabled for it"
  }
}

variable "subdomain" {
  description = "(optional) subdomain"
  type        = string
  nullable    = true
  default     = null
}

data "porkbun_domains" "account" {}
