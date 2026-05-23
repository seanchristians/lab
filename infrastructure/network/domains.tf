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

data "porkbun_domain" "ddns_proxy" {
  domain = "sean.directory"
}

resource "terraform_data" "minecraft_domain_desec_token" {
  input = desec_token.minecraft_domain.token

  triggers_replace = desec_token.minecraft_domain.id

  lifecycle {
    ignore_changes = [input]
  }
}

resource "desec_token" "minecraft_domain" {
  max_age           = null
  max_unused_period = null

  lifecycle {
    replace_triggered_by = [terraform_data.api_token_sentinel]
  }
}

resource "desec_token_policy" "minecraft_domain_default" {
  token_id   = desec_token.minecraft_domain.id
  perm_write = false
}

resource "desec_token_policy" "minecraft_domain_a" {
  token_id   = desec_token.minecraft_domain.id
  domain     = desec_domain.ddns_proxy.id
  subname    = "minecraft"
  perm_write = true
  type       = "A"

  depends_on = [desec_token_policy.minecraft_domain_default]
}

resource "desec_token_policy" "minecraft_domain_aaaa" {
  token_id   = desec_token.minecraft_domain.id
  domain     = desec_domain.ddns_proxy.id
  subname    = "minecraft"
  perm_write = true
  type       = "AAAA"

  depends_on = [desec_token_policy.minecraft_domain_default]
}
