resource "spacelift_stack" "tailscale" {
  branch       = "main"
  name         = "tailscale"
  repository   = "lab"
  project_root = "tailscale"

  allow_run_promotion = true
  autodeploy          = true

  manage_state = true
  space_id     = spacelift_space.production.id
}
