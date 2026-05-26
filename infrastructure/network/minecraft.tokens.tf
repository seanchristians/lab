resource "terraform_data" "minecraft_domain_desec_token" {
  store {
    input     = desec_token.minecraft_domain.token
    sensitive = true
  }

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
