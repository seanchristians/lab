resource "spacelift_environment_variable" "tailscale_identity_token" {
  name       = "TAILSCALE_IDENTITY_TOKEN"
  value      = "${SPACELIFT_OIDC_TOKEN}"
  context_id = spacelift_context.tailscale.id
}
