variable "domain" {
  type        = string
  description = "Top-level target domain"
  sensitive   = false
  nullable    = false
}

variable "subdomain" {
  type        = string
  description = "Subdomain of the target domain"
  sensitive   = false
  nullable    = false
}

variable "proxy_subdomain" {
  type        = string
  description = "Subdomain of the DNS proxy domain"
  sensitive   = false
  nullable    = false
}

variable "proxy_domain" {
  type        = string
  description = "DNS proxy domain"
  sensitive   = false
  nullable    = false
  default     = "sean.directory"
}
