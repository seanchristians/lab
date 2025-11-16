resource "spacelift_context" "lab" {
  name     = "lab"
  space_id = data.spacelift_space.root.id
}
