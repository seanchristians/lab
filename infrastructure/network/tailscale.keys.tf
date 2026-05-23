resource "tailscale_tailnet_key" "container" {
  description         = "For Tailscale sidecar containers"
  ephemeral           = true
  preauthorized       = true
  recreate_if_invalid = "always"
  reusable            = true
  tags                = ["tag:infrastructure"]

  lifecycle {
    replace_triggered_by = [terraform_data.api_token_sentinel]
  }
}
