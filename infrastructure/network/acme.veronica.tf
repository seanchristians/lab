# resource "desec_token" "veronica" {
#   name               = "veronica"
#   auto_policy        = true
#   perm_create_domain = false
#   perm_delete_domain = false
#   perm_manage_tokens = false

#   connection {
#     type            = "ssh"
#     user            = "acme"
#     host            = "veronica.${data.porkbun_domain.network.domain}"
#     target_platform = "unix"
#   }

#   provisioner "file" {
#     content     = self.token
#     destination = "/etc/acme/auth/desec.token"
#   }
# }

resource "restapi_object" "desec_token_veronica" {
  provider = restapi.desec
  path     = "/auth/tokens"

  data = jsonencode({
    name               = "veronica"
    perm_create_domain = false
    perm_delete_domain = false
    perm_manage_tokens = false
  })
}

# resource "desec_token_policy" "veronica" {
#   token_id   = desec_token.veronica.id
#   perm_write = true
#   domain     = desec_domain.acme_challenge["veronica"].name
#   type       = "TXT"
# }

resource "restapi_object" "desec_token_default_policy_veronica" {
  provider = restapi.desec
  path     = "/auth/tokens/${restapi_object.desec_token_veronica.id}/policies/rrsets"

  data = jsonencode({
    domain  = null
    subname = null
    type    = null
  })
}

resource "restapi_object" "desec_token_policy_veronica" {
  provider = restapi.desec
  path     = "/auth/tokens/${restapi_object.desec_token_veronica.id}/policies/rrsets"

  data = jsonencode({
    domain     = restapi_object.desec_domain_acme_challenge["veronica"].api_data.name
    subname    = null
    type       = "TXT"
    perm_write = true
  })
}
