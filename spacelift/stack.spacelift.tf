data "spacelift_current_stack" "this" {}

data "spacelift_stack" "spacelift" {
  stack_id = data.spacelift_current_stack.this.id
}
