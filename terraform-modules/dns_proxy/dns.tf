resource "porkbun_dns_record" "cname" {
  domain    = var.domain
  subdomain = var.subdomain
  type      = "CNAME"
  content   = "${var.proxy_subdomain}.${var.proxy_domain}"
}
