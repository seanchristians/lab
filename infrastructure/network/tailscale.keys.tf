resource "tailscale_tailnet_key" "squiggle_darkened" {
  ephemeral           = true
  preauthorized       = true
  recreate_if_invalid = "always"
  reusable            = true
  tags                = ["tag:infrastructure"]
}
