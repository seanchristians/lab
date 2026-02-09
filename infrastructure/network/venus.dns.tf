data "tailscale_device" "venus" {
  hostname = split(".", aws_instance.venus.private_dns)[0]
}

resource "porkbun_dns_record" "venus" {
  domain    = data.porkbun_domain.network.domain
  subdomain = "venus"
  type      = "CNAME"
  content   = "${local.tailnet_dns_name}.${data.tailscale_device.venus.hostname}"
}
