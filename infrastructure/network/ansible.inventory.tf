locals {
  ansible_inventory = {
    wireguard_servers = { hosts = {
      "squiggle-darkened" = {
        ansible_host           = data.tailscale_device.squiggle_darkened.name
        ansible_user           = "root"
        ansible_ssh_extra_args = "-o StrictHostKeyChecking=no"
        tailscale_auth_key     = tailscale_tailnet_key.container.key
        tailnet_service        = tailscale_service.minecraft.id
        wireguard_domain       = "${porkbun_dns_record.minecraft_server.subdomain}.${porkbun_dns_record.minecraft_server.domain}"
        wireguard_dns          = "149.112.121.10,149.112.122.10,2620:10A:80BB::10,2620:10A:80BC::10" # CIRA Canadian Shield
        wireguard_ipv4_cidr    = "172.30.0.0/24"
        wireguard_ipv6_cidr    = "fdef:aced::/64"
        desec_token            = ephemeral.desec_token.minecraft_domain.token
      }
    } }
  }
}

data "tailscale_device" "squiggle_darkened" {
  hostname = "squiggle-darkened"
}
