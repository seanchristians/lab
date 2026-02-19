resource "restapi_object" "desec_token_veronica" {
  provider                = restapi.desec
  path                    = "/auth/tokens"
  ignore_server_additions = true

  data = jsonencode({
    name               = "veronica"
    perm_create_domain = false
    perm_delete_domain = false
    perm_manage_tokens = false
  })
}

resource "restapi_object" "desec_token_default_policy_veronica" {
  provider                = restapi.desec
  path                    = "/auth/tokens/${restapi_object.desec_token_veronica.id}/policies/rrsets"
  ignore_server_additions = true


  data = jsonencode({
    domain     = null
    subname    = null
    type       = null
    perm_write = false
  })
}

resource "restapi_object" "desec_token_policy_veronica" {
  provider                = restapi.desec
  path                    = "/auth/tokens/${restapi_object.desec_token_veronica.id}/policies/rrsets"
  ignore_server_additions = true

  data = jsonencode({
    domain     = data.porkbun_domain.acme_challenge.domain
    subname    = "veronica"
    type       = "TXT"
    perm_write = true
  })
}
