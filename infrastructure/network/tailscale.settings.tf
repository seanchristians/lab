resource "tailscale_tailnet_settings" "primary" {
  acls_externally_managed_on = true
  acls_external_link         = "https://github.com/seanchristians/lab/blob/main/${data.external.module_path_in_git_repo.result.content}${data.local_file.tailnet_policy.filename}"

  devices_approval_on       = true
  devices_auto_updates_on   = false
  devices_key_duration_days = 30

  users_approval_on = true
}
