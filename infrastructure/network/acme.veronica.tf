module "desec_token_veronica" {
  source = "./acme_token"

  subdomain   = "veronica"
  domain      = data.porkbun_domain.network.domain
  acme_domain = data.porkbun_domain.acme_challenge.domain
}

resource "terraform_data" "desec_token_veronica" {
  triggers_replace = "86DB5C34-6761-4ECD-9A91-FE8DC7A16EB2"

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
