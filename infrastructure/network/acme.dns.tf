locals {
  desec_nameservers = [
    "ns1.desec.io",
    "ns2.desec.org"
  ]

  acme_challenge_domains = [
    "veronica"
  ]
}

resource "porkbun_nameservers" "acme_challenge" {
  domain      = data.porkbun_domain.acme_challenge.domain
  nameservers = local.desec_nameservers
}

resource "restapi_object" "desec_domain_acme_challenge" {
  path                    = "/domains"
  ignore_server_additions = true
  id_attribute            = "name"

  debug = true

  data = jsonencode({
    name = data.porkbun_domain.acme_challenge.domain
  })
}

output "desec_domain_api_response" {
  value = restapi_object.desec_domain_acme_challenge.api_response
}

output "desec_domain_api_create_response" {
  value = restapi_object.desec_domain_acme_challenge.create_response
}

resource "porkbun_dns_record" "acme_challenge" {
  for_each = toset(local.acme_challenge_domains)

  domain    = data.porkbun_domain.network.domain
  subdomain = "_acme-challenge.${each.key}"
  type      = "CNAME"
  content   = "${each.key}.${data.porkbun_domain.acme_challenge.domain}"
}
