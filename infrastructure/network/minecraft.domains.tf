locals {
  minecraft_server_vpn_subdomain = "minecraft"
}

resource "porkbun_dns_record" "minecraft_server_a" {
  domain    = local.domain_canada
  subdomain = "minecraft"
  type      = "A"
  content   = "172.30.0.1"
}

resource "porkbun_dns_record" "minecraft_server_aaaa" {
  domain    = local.domain_canada
  subdomain = "minecraft"
  type      = "AAAA"
  content   = "fdef:aced::1"
}
