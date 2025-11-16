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

resource "spacelift_context_attachment" "tailscale" {
  context_id = spacelift_context.lab.id
  stack_id   = spacelift_stack.tailscale.id
  priority   = 0
}
