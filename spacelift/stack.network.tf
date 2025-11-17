resource "spacelift_stack" "network" {
  branch       = "main"
  name         = "network"
  repository   = "lab"
  project_root = "network"

  allow_run_promotion = true
  autodeploy          = true

  manage_state = true
  space_id     = spacelift_space.production.id
}

resource "spacelift_stack" "tailscale" {
  branch       = "main"
  name         = "network"
  repository   = "lab"
  project_root = "network"

  allow_run_promotion = true
  autodeploy          = true

  manage_state = true
  space_id     = spacelift_space.production.id
}

import {
  to = spacelift_stack.network
  id = spacelift_stack.tailscale.id
}
