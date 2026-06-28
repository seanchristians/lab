locals {
  minecraft_server_dns_proxy_domain = join(".", [var.minecraft_server_device, local.dns_proxy_domain])
}

resource "porkbun_dns_record" "minecraft_server" {
  domain    = local.domain_canada
  subdomain = "minecraft"
  type      = "CNAME"
  content   = local.minecraft_server_dns_proxy_domain
}
