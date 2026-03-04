data "dns_ns_record_set" "desec" {
  host = "desec.io"
}

resource "porkbun_nameservers" "acme_challenge" {
  domain      = local.acme_challenge_domain
  nameservers = trimsuffix(data.dns_ns_record_set.desec.nameservers[*], ".")
}

resource "restapi_object" "desec_domain_acme_challenge" {
  path                    = "/domains/"
  ignore_server_additions = true
  id_attribute            = "name"

  data = jsonencode({
    name = local.acme_challenge_domain
  })
}
