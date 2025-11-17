resource "spacelift_environment_variable" "tailscale_tailnet_id" {
  name       = "tailscale_tailnet_id"
  context_id = spacelift_context.tailscale.id
  write_only = false
  value      = "TA1163u8TV11CNTRL"
}

resource "spacelift_environment_variable" "tailscale_oauth_client_id" {
  name       = "ro_tailscale_oauth_client_id"
  context_id = spacelift_context.tailscale.id
  write_only = false
}

resource "spacelift_environment_variable" "tailscale_oauth_client_secret" {
  name       = "ro_tailscale_oauth_client_secret"
  context_id = spacelift_context.tailscale.id
}
