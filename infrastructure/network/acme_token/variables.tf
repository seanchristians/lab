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
