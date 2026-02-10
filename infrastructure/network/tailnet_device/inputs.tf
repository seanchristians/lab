variable "tailnet_hostname" {
  type        = string
  description = "Hostname of the device in Tailscale"
}

variable "subdomain" {
  type        = string
  description = "Subdomain where a DNS record will be created for the device"
}
