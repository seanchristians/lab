resource "porkbun_dns_record" "mx_1" {
  domain    = var.domain
  subdomain = var.subdomain
  type      = "MX"
  content   = "mail.anonaddy.me."
  prio      = 10
}

resource "porkbun_dns_record" "mx_2" {
  domain    = var.domain
  subdomain = var.subdomain
  type      = "MX"
  content   = "mail2.anonaddy.me."
  prio      = 20
}

resource "porkbun_dns_record" "spf" {
  domain    = var.domain
  subdomain = var.subdomain
  type      = "TXT"
  content   = "v=spf1 include:spf.anonaddy.me -all"
}

resource "porkbun_dns_record" "dkim_1" {
  domain    = var.domain
  subdomain = var.subdomain ? "dk1._domainkey.${var.subdomain}" : "dk1._domainkey"
  type      = "CNAME"
  content   = "dk1._domainkey.anonaddy.me."
}

resource "porkbun_dns_record" "dkim_2" {
  domain    = var.domain
  subdomain = var.subdomain ? "dk2._domainkey.${var.subdomain}" : "dk2._domainkey"
  type      = "CNAME"
  content   = "dk2._domainkey.anonaddy.me."
}

resource "porkbun_dns_record" "dmarc" {
  domain    = var.domain
  subdomain = var.subdomain ? "_dmarc.${var.subdomain}" : "_dmarc"
  type      = "TXT"
  content   = "v=DMARC1; p=quarantine; adkim=s"
}
