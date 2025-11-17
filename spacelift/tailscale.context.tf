resource "spacelift_context" "tailscale" {
  name        = "tailscale"
  description = "Tailnet environment variables"
  space_id    = spacelift_space.production.id
}
