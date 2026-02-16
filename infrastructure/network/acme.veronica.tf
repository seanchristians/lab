resource "desec_token" "veronica" {
  name               = "veronica"
  auto_policy        = true
  perm_create_domain = false
  perm_delete_domain = false
  perm_manage_tokens = false

  connection {
    type            = "ssh"
    user            = "acme"
    host            = desec_domain.acme_challenge["veronica"].name
    target_platform = "unix"
  }

  provisioner "file" {
    content     = self.token
    destination = "/etc/acme/auth/desec.token"
  }
}

resource "desec_token_policy" "veronica" {
  token_id   = desec_token.veronica.id
  perm_write = true
  domain     = desec_domain.acme_challenge["veronica"].name
  type       = "TXT"
}
