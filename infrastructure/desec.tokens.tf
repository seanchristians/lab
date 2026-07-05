resource "desec_token" "host" {
  for_each = toset(var.ddns_servers)

  max_age           = null
  max_unused_period = null

  lifecycle {
    replace_triggered_by = [terraform_data.api_token_sentinel]
  }

  depends_on = [desec_domain.dns_proxy]

  connection {
    type = "ssh"
    host = each.key
  }

  provisioner "remote-exec" {
    inline = ["mkdir -p ddns"]
  }

  provisioner "file" {
    content     = self.token
    destination = "ddns/desec.token"
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
