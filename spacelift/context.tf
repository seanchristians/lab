resource "spacelift_context_attachment" "tailscale_spacelift" {
  context_id = spacelift_context.tailscale.id
  stack_id   = spacelift_stack.spacelift.id
}
