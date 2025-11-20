resource "spacelift_context" "tailscale" {
  name = "tailscale"
}

resource "spacelift_context_attachment" "tailscale_network" {
  context_id = spacelift_context.tailscale.id
  stack_id   = spacelift_stack.network.id
}
