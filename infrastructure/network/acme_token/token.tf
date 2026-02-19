resource "restapi_object" "desec_token" {
  path                    = "/auth/tokens/"
  ignore_server_additions = true

  data = jsonencode({
    name               = var.subdomain
    perm_create_domain = false
    perm_delete_domain = false
    perm_manage_tokens = false
  })
}

resource "restapi_object" "desec_token_default_policy" {
  path                    = "/auth/tokens/${restapi_object.desec_token.id}/policies/rrsets/"
  ignore_server_additions = true

  data = jsonencode({
    domain  = null
    subname = null
    type    = null
  })
}

resource "restapi_object" "desec_token_policy_veronica" {
  path                    = "/auth/tokens/${restapi_object.desec_token.id}/policies/rrsets/"
  ignore_server_additions = true

  depends_on = [restapi_object.desec_token_default_policy]

  data = jsonencode({
    domain     = var.acme_domain
    subname    = var.subdomain
    type       = "TXT"
    perm_write = true
  })
}
