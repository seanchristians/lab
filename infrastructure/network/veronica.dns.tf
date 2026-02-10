module "dns_veronica" {
  source           = "./tailnet_device"
  subdomain        = "veronica"
  tailnet_hostname = "veronica"
}
