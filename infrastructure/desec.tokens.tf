resource "desec_token" "host" {
  for_each = var.ddns_servers

  max_age           = null
  max_unused_period = null

  lifecycle {
    replace_triggered_by = [terraform_data.api_token_sentinel]
  }

  depends_on = [desec_domain.dns_proxy]

  provisioner "local-exec" {
    environment = { SSH_HOST = each.key }
    command     = "ssh $SSH_HOST 'mkdir -p ddns'"
  }

  provisioner "local-exec" {
    environment = {
      SSH_HOST    = each.key
      DESEC_TOKEN = self.token
    }
    command = "echo \"$DESEC_TOKEN\" | ssh $SSH_HOST 'mkdir -p ~/ddns cat > ~/ddns/desec.token'"
  }
}

removed {
  from = desec_token.host["squiggle-darkened"]

  lifecycle {
    destroy = true
  }
}

resource "desec_token_policy" "default" {
  for_each = desec_token.host

  token_id   = each.value.id
  perm_write = false
}

resource "desec_token_policy" "a" {
  for_each = desec_token_policy.default

  token_id   = each.value.token_id
  domain     = desec_domain.dns_proxy.id
  subname    = each.key
  perm_write = true
  type       = "A"
}

resource "desec_token_policy" "aaaa" {
  for_each = desec_token_policy.default

  token_id   = each.value.token_id
  domain     = desec_domain.dns_proxy.id
  subname    = each.key
  perm_write = true
  type       = "AAAA"
}
