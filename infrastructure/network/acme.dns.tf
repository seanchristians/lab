locals {
  gcore_nameservers = [
    "ns1.gcorelabs.net",
    "ns2.gcdn.services"
  ]

  acme_challenge_domains = [
    "veronica"
  ]
}

resource "porkbun_nameservers" "acme_challenge" {
  domain      = data.porkbun_domain.acme_challenge.domain
  nameservers = local.gcore_nameservers
}

resource "gcore_dns_zone" "acme_challenge" {
  for_each = toset(local.acme_challenge_domains)

  name   = "${each.key}.${data.porkbun_domain.acme_challenge.domain}"
  dnssec = true

  depends_on = [porkbun_nameservers.acme_challenge]
}

resource "porkbun_dns_record" "acme_challenge" {
  for_each = toset(local.acme_challenge_domains)

  domain    = data.porkbun_domain.acme_challenge.domain
  subdomain = "_acme-challenge.${each.key}"
  type      = "CNAME"
  content   = gcore_dns_zone.acme_challenge[each.key].name
}
