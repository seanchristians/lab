resource "porkbun_dns_record" "shortio" {
  domain    = var.primary_domain
  subdomain = "go"
  type      = "CNAME"
  content   = "cname.short.io"
}
