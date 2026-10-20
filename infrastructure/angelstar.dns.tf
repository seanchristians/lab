locals {
  angel_art_domain = "angelstar.ca"
  canva_ip         = "103.169.142.6"
  canva_subdomains = ["", "www"]
  canva_dv_code    = "canva-domain-verify=933963758cb5880f66996e3b8bcd68d227804b129a516faa7474544bb7c16c4e"
}

resource "porkbun_dns_record" "angel_art_canva" {
  for_each = toset(local.canva_subdomains)

  domain    = local.angel_art_domain
  subdomain = each.value
  type      = "A"
  content   = local.canva_ip
}

resource "porkbun_dns_record" "angel_art_canva_verification" {
  domain    = local.angel_art_domain
  subdomain = ""
  type      = "TXT"
  content   = local.canva_dv_code
}
