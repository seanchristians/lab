locals {
  minecraft_server_vpn_subdomain = "minecraft"
}

resource "porkbun_dns_record" "minecraft_server" {
  domain    = local.domain_canada
  subdomain = "minecraft"
  type      = "CNAME"
  content   = "${local.minecraft_server_vpn_subdomain}.${desec_domain.dns_proxy.name}"
}
