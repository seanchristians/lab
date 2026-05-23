resource "porkbun_dns_record" "minecraft_server" {
  domain    = "seanchristians.ca"
  subdomain = "minecraft"
  type      = "CNAME"
  content   = "minecraft.${data.porkbun_domain.ddns_proxy.domain}"
}

resource "porkbun_nameservers" "ddns_proxy" {
  domain      = data.porkbun_domain.ddns_proxy.domain
  nameservers = data.dns_ns_record_set.desec_io.nameservers
}

data "porkbun_domain" "ddns_proxy" {
  domain = "sean.directory"
}

data "dns_ns_record_set" "desec_io" {
  host = "desec.io"
}
