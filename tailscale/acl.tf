data "local_file" "tailnet_policy" {
  filename = "./tailnet_policy.hujson"
}

resource "tailscale_acl" "tailnet" {
  acl                        = local_file.tailnet_policy.content
  overwrite_existing_content = true
  reset_acl_on_destroy       = false
}
