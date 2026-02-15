locals {
  gcore_nameservers = [
    "ns1.gcorelabs.net",
    "ns2.gcdn.services"
  ]
}

resource "porkbun_nameservers" "acme_challenge" {
  domain      = data.porkbun_domain.acme_challenge.domain
  nameservers = local.gcore_nameservers
}

resource "gcore_dns_zone" "veronica" {
  name   = "veronica.${data.porkbun_domain.acme_challenge.domain}"
  dnssec = true

  depends_on = [porkbun_nameservers.acme_challenge]
}
