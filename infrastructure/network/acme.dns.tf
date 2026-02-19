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

# resource "restapi_object" "desec_domain_acme_challenge" {
#   path                    = "/domains"
#   ignore_server_additions = true
#   id_attribute            = "name"

#   debug = true

#   data = jsonencode({
#     name = data.porkbun_domain.acme_challenge.domain
#   })
# }

resource "porkbun_dns_record" "acme_challenge" {
  for_each = toset(local.acme_challenge_domains)

  domain    = data.porkbun_domain.network.domain
  subdomain = "_acme-challenge.${each.key}"
  type      = "CNAME"
  content   = "${each.key}.${data.porkbun_domain.acme_challenge.domain}"
}

data "http" "desec_domain_acme_challenge" {
  url    = "https://desec.io/api/v1/domains/"
  method = "POST"

  request_body = jsonencode({
    name = data.porkbun_domain.acme_challenge.domain
  })

  request_headers = {
    Authorization = "Token ${var.desec_token}"
    Content-Type  = "application/json"
  }

  retry {
    attempts     = 5
    max_delay_ms = 30
    min_delay_ms = 1
  }
}

output "desec_domain_api_response" {
  value = data.http.desec_domain_acme_challenge.response_body
}
