resource "porkbun_dns_record" "minecraft_server_vpn" {
  domain    = local.domain_canada
  subdomain = "mc-vpn"
  type      = "CNAME"
  content   = "mc-vpn.${data.porkbun_domain.dns_proxy.domain}"
}
