variable "tailscale_tailnet_id" {
  type = string
}

variable "tailscale_oauth" {
  type = object({
    client_id     = string
    client_secret = string
  })
  sensitive = true
}
