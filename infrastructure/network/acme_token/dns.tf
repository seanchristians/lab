resource "porkbun_dns_record" "this" {
  domain    = var.domain
  subdomain = "_acme-challenge.${var.subdomain}"
  type      = "CNAME"
  content   = "${var.subdomain}.${var.acme_domain}"
}
