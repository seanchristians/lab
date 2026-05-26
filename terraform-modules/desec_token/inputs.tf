variable "subdomain" {
  type        = string
  description = "Subdomain of the DNS proxy domain"
  sensitive   = false
  nullable    = false
}

variable "domain" {
  type        = string
  description = "DNS proxy domain"
  sensitive   = false
  nullable    = false
  default     = "sean.directory"
}

variable "version" {
  type        = number
  description = "Version number of this secret. Bump to replace the token."
  sensitive   = false
  nullable    = false
  default     = 0
}
