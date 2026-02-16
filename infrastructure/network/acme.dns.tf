locals {
  desec_nameservers = [
    "ns1.desec.io",
    "ns2.desec.org"
  ]

  acme_challenge_domains = [
    "veronica"
  ]
}

resource "porkbun_nameservers" "acme_challenge" {
  domain      = data.porkbun_domain.acme_challenge.domain
  nameservers = local.desec_nameservers
}

resource "desec_domain" "acme_challenge" {
  for_each = toset(local.acme_challenge_domains)

  name = "${each.key}.${data.porkbun_domain.acme_challenge.domain}"
}

resource "porkbun_dns_record" "acme_challenge" {
  for_each = desec_domain.acme_challenge

  domain    = data.porkbun_domain.network.domain
  subdomain = "_acme-challenge.${each.key}"
  type      = "CNAME"
  content   = each.value.name
}

resource "desec_token" "acme_challenge" {
  for_each = desec_domain.acme_challenge

  auto_policy        = true
  perm_create_domain = false
  perm_delete_domain = false
  perm_manage_tokens = false
}

resource "desec_token_policy" "acme_challenge" {
  for_each = desec_token.acme_challenge

  token_id   = each.value.id
  perm_write = true
  domain     = desec_domain.acme_challenge[each.key].name
  type       = "TXT"
}

resource "terraform_data" "desec_tokens" {
  for_each = desec_token.acme_challenge

  input = each.value.token

  lifecycle {
    ignore_changes = [input]
  }
}
