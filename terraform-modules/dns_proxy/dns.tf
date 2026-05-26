resource "porkbun_dns_record" "cname" {
  domain    = var.domain
  subdomain = var.subdomain
  type      = "CNAME"
  content   = local.target_domain
}

locals {
  target_domain = "${var.proxy_subdomain}.${var.proxy_domain}"
}
