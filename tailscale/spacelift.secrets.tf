data "spacelift_stack" "tailscale" {
  stack_id = "tailscale"
}

resource "spacelift_environment_variable" "tailscale_oauth_client_id" {
  name     = "TF_VAR_tailscale_oauth_client_id"
  stack_id = data.spacelift_stack.tailscale.id
}

resource "spacelift_environment_variable" "tailscale_oauth_client_secret" {
  name     = "TF_VAR_tailscale_oauth_client_secret"
  stack_id = data.spacelift_stack.tailscale.id
}
