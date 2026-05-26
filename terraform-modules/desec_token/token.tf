resource "terraform_data" "desec_token" {
  input = desec_token.token.token

  triggers_replace = desec_token.token.id

  lifecycle {
    ignore_changes = [input]
  }
}

resource "desec_token" "token" {
  max_age           = null
  max_unused_period = null

  lifecycle {
    replace_triggered_by = [terraform_data.secret_version]
  }
}

resource "terraform_data" "secret_version" {
  triggers_replace = var.version
}

resource "desec_token_policy" "default" {
  token_id   = desec_token.token.id
  perm_write = false
}

resource "desec_token_policy" "a_record" {
  token_id   = desec_token.token.id
  domain     = var.domain
  subname    = var.subdomain
  perm_write = true
  type       = "A"

  depends_on = [desec_token_policy.default]
}

resource "desec_token_policy" "aaaa_record" {
  token_id   = desec_token.token.id
  domain     = var.domain
  subname    = var.subdomain
  perm_write = true
  type       = "AAAA"

  depends_on = [desec_token_policy.default]
}
