resource "restapi_object" "desec_token_veronica" {
  path                    = "/auth/tokens/"
  query_string            = "/"
  ignore_server_additions = true

  data = jsonencode({
    name               = "veronica"
    perm_create_domain = false
    perm_delete_domain = false
    perm_manage_tokens = false
  })
}

resource "restapi_object" "desec_token_policy_veronica" {
  path                    = "/auth/tokens/${restapi_object.desec_token_veronica.id}/policies/rrsets/"
  query_string            = "/"
  ignore_server_additions = true


  data = jsonencode({
    domain     = restapi_object.desec_domain_acme_challenge.api_data.name
    subname    = "veronica"
    type       = "TXT"
    perm_write = true
  })
}
