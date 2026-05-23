resource "porkbun_dns_record" "minecraft_seanchristians_ca" {
  domain    = "seanchristians.ca"
  subdomain = "minecraft"
  type      = "CNAME"
  content   = "minecraft.sean.directory"
}

resource "porkbun_nameservers" "sean_directory" {
  domain      = "sean.directory"
  nameservers = data.dns_ns_record_set.desec_io.nameservers
}

data "dns_ns_record_set" "desec_io" {
  host = "desec.io"
}
