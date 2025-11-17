resource "network_stack" "network" {
  branch       = "main"
  name         = "network"
  repository   = "lab"
  project_root = "network"

  allow_run_promotion = true
  autodeploy          = true

  manage_state = true
  space_id     = spacelift_space.production.id
}
