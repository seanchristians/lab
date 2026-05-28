resource "cloudflare_zone" "dns_proxy" {
  account = {
    id = local.cloudflare_account_id
  }
  name = local.dns_proxy_domain
}

resource "porkbun_nameservers" "dns_proxy" {
  domain      = data.porkbun_domain.dns_proxy.domain
  nameservers = cloudflare_zone.dns_proxy.name_servers
}

data "porkbun_domain" "dns_proxy" {
  domain = local.dns_proxy_domain
}
