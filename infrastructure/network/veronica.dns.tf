# data "tailscale_device" "veronica" {
#   hostname = "veronica"
# }

# resource "porkbun_dns_record" "veronica" {
#   domain    = data.porkbun_domain.network.domain
#   subdomain = "veronica"
#   type      = "CNAME"
#   content   = "${data.tailscale_device.veronica.hostname}.${local.tailnet_dns_name}"
# }

module "dns_veronica" {
  source           = "./tailnet_device"
  subdomain        = "veronica"
  tailnet_hostname = "veronica"
}
