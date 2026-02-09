data "tailscale_device" "venus" {
  hostname = split(".", aws_instance.venus.private_dns)[0]
}

resource "terraform_data" "tailscale_device_venus" {
  input = data.tailscale_device.venus.name

  depends_on = [tailscale_dns_preferences.default]
}

resource "porkbun_dns_record" "venus" {
  domain    = data.porkbun_domain.network.domain
  subdomain = "venus"
  type      = "CNAME"
  content   = terraform_data.tailscale_device_venus.output
}
