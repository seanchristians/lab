resource "porkbun_dns_record" "minecraft_server" {
  domain    = "seanchristians.ca"
  subdomain = "minecraft"
  type      = "CNAME"
  content   = "minecraft.${data.porkbun_domain.ddns_proxy.domain}"
}

resource "porkbun_nameservers" "ddns_proxy" {
  domain      = data.porkbun_domain.ddns_proxy.domain
  nameservers = [for ns in data.desec_rrset.ddns_proxy_nameservers.rdata : trimsuffix(ns, ".")]
}

resource "desec_domain" "ddns_proxy" {
  name = data.porkbun_domain.ddns_proxy.domain
}

data "desec_rrset" "ddns_proxy_nameservers" {
  domain  = desec_domain.ddns_proxy.id
  subname = "@"
  type    = "NS"
}

data "porkbun_domain" "dns_proxy" {
  domain = local.dns_proxy_domain
}
