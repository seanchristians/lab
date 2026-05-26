resource "terraform_data" "minecraft_vpn_domain_desec_token" {
  store {
    input     = desec_token.minecraft_server_vpn.token
    sensitive = true
  }

  triggers_replace = desec_token.minecraft_server_vpn.id

  lifecycle {
    ignore_changes = [input]
  }
}

resource "desec_token" "minecraft_server_vpn" {
  max_age           = null
  max_unused_period = null

  lifecycle {
    replace_triggered_by = [terraform_data.api_token_sentinel]
  }
}

resource "desec_token_policy" "minecraft_server_vpn_default" {
  token_id   = desec_token.minecraft_server_vpn.id
  perm_write = false
}

resource "desec_token_policy" "minecraft_server_vpn_a" {
  token_id   = desec_token.minecraft_server_vpn.id
  domain     = desec_domain.dns_proxy.id
  subname    = porkbun_dns_record.minecraft_server_vpn.subdomain
  perm_write = true
  type       = "A"

  depends_on = [desec_token_policy.minecraft_server_vpn_default]
}

resource "desec_token_policy" "minecraft_server_vpn_aaaa" {
  token_id   = desec_token.minecraft_server_vpn.id
  domain     = desec_domain.dns_proxy.id
  subname    = porkbun_dns_record.minecraft_server_vpn.subdomain
  perm_write = true
  type       = "AAAA"

  depends_on = [desec_token_policy.minecraft_server_vpn_default]
}
