module "minecraft_vpn_domain" {
  source = "../../terraform-modules/dns-proxy"

  domain          = "seanchristians.ca"
  subdomain       = "minecraft"
  proxy_subdomain = "minecraft"
}
