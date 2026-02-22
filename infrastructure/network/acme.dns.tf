locals {
  desec_nameservers = [
    "ns1.desec.io",
    "ns2.desec.org"
  ]
}

resource "porkbun_nameservers" "acme_challenge" {
  domain      = local.acme_challenge_domain
  nameservers = local.desec_nameservers
}

resource "restapi_object" "desec_domain_acme_challenge" {
  path                    = "/domains/"
  ignore_server_additions = true
  id_attribute            = "name"

  data = jsonencode({
    name = local.acme_challenge_domain
  })
}
