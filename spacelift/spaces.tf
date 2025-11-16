data "spacelift_space" "root" {
  space_id = "root"
}

resource "spacelift_space" "production" {
  name = "production"
  inherit_entities = true
  parent_space_id = data.spacelift_space.root.id
}
