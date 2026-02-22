module "desec_token_veronica" {
  source = "./acme_token"

  subdomain   = "veronica"
  domain      = local.network_domain
  acme_domain = local.acme_challenge_domain

  sentinel = "09DAB4EB-2625-4BBA-AC6F-19CD06626581"
}

resource "terraform_data" "desec_token_veronica" {
  triggers_replace = module.desec_token_veronica.last_updated

  connection {
    type            = "ssh"
    user            = "acme"
    host            = module.desec_token_veronica.fqdn
    target_platform = "unix"
  }

  provisioner "file" {
    content     = module.desec_token_veronica.token
    destination = "/etc/acme/auth/desec.token"
  }
}
