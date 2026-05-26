resource "porkbun_nameservers" "dns_proxy" {
  domain      = data.porkbun_domain.dns_proxy.domain
  nameservers = [for ns in data.desec_rrset.dns_proxy_nameservers.rdata : trimsuffix(ns, ".")]
}

resource "porkbun_dnssec_record" "dns_proxy" {
  domain   = data.porkbun_domain.dns_proxy.domain
  ds_data  = desec_domain.dns_proxy.keys.ds
  key_data = desec_domain.dns_proxy.keys.dnskey
}

resource "desec_domain" "dns_proxy" {
  name = data.porkbun_domain.dns_proxy.domain
}

data "desec_rrset" "dns_proxy_nameservers" {
  domain  = desec_domain.dns_proxy.id
  subname = "@"
  type    = "NS"
}

data "porkbun_domain" "dns_proxy" {
  domain = local.dns_proxy_domain
}
