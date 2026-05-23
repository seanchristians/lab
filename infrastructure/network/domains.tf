resource "porkbun_dns_record" "minecraft_server" {
  domain    = "seanchristians.ca"
  subdomain = "minecraft"
  type      = "CNAME"
  content   = "minecraft.${data.porkbun_domain.ddns_proxy.domain}"
}

resource "porkbun_nameservers" "ddns_proxy" {
  domain      = data.porkbun_domain.ddns_proxy.domain
  nameservers = data.desec_rrset.ddns_proxy_nameservers.rdata
}

data "desec_rrset" "ddns_proxy_nameservers" {
  domain  = data.porkbun_domain.ddns_proxy.domain
  subname = "@"
  type    = "NS"
}

data "porkbun_domain" "ddns_proxy" {
  domain = "sean.directory"
}
