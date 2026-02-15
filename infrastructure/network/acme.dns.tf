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

resource "desec_domain" "acme_challenge" {
  for_each = toset(local.acme_challenge_domains)

  name = "${each.key}.${data.porkbun_domain.acme_challenge.domain}"
}

resource "porkbun_dns_record" "acme_challenge" {
  for_each = toset(local.acme_challenge_domains)

  domain    = data.porkbun_domain.network.domain
  subdomain = "_acme-challenge.${each.key}"
  type      = "CNAME"
  content   = "${each.key}.${data.porkbun_domain.acme_challenge.domain}"
}
