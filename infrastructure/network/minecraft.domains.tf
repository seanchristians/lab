module "minecraft_vpn_domain" {
  source = "../../terraform-modules/dns_proxy"

  domain          = data.porkbun_domains.canada.domain
  subdomain       = "minecraft"
  proxy_subdomain = "minecraft"
}
