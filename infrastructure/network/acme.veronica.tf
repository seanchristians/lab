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
