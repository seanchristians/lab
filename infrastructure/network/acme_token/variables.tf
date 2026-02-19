variable "subdomain" {
  type        = string
  description = "Subdomain that the network device will occupy."
  nullable    = false
}

variable "domain" {
  type        = string
  description = "Primary domains used by devices in the network."
  nullable    = false
}

variable "acme_domain" {
  type        = string
  description = "Alias domain where ACME challenges will be answered with the DNS-01 method."
  nullable    = false
}

variable "sentinel" {
  type        = string
  description = "Sentinel value that triggers replacing the token"
  default     = true
}

resource "terraform_data" "sentinel" {
  triggers_replace = var.sentinel
}
