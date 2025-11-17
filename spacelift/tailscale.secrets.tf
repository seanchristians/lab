resource "spacelift_environment_variable" "tailscale_oauth_client_id" {
  name     = "TF_VAR_tailscale_oauth_client_id"
  stack_id = spacelift_stack.tailscale.id
}

resource "spacelift_environment_variable" "tailscale_oauth_client_secret" {
  name     = "TF_VAR_tailscale_oauth_client_secret"
  stack_id = spacelift_stack.tailscale.id
}
