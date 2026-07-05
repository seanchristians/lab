resource "porkbun_dns_record" "ddns_cname" {
  for_each = local.ddns_domains

  domain    = each.value.apex_domain
  subdomain = each.value.subdomain
  type      = each.value.subdomain == "" ? "ALIAS" : "CNAME"
  content   = each.value.target_domain
}

locals {
  ddns_domains = merge([for host, values in var.ddns_servers : { for domain in values.alias_domains : domain =>
    one([for apex_domain in data.porkbun_domains.all.domains[*].domain : {
      apex_domain   = apex_domain
      subdomain     = domain == apex_domain ? "" : trimsuffix(domain, ".${apex_domain}")
      target_domain = "${host}.${var.dns_proxy_domain}"
    } if strcontains(domain, apex_domain)])
  }]...)
}
