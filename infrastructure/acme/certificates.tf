data "sops_file" "dns_providers" {
  source_file = "dns-providers.enc.json"
}

resource "acme_certificate" "veronica" {
  account_key_pem = acme_registration.letsencrypt.account_key_pem
  common_name     = "veronica.${var.domain}"

  dns_challenge {
    provider               = "porkbun"
    PORKBUN_API_KEY        = data.sops_file.dns_providers.data["PORKBUN_API_KEY"]
    PORKBUN_SECRET_API_KEY = data.sops_file.dns_providers.data["PORKBUN_SECRET_API_KEY"]
  }
}

# Separating the resource from the provisioner allows me to use Terraform's
# "replace" method when I need to re-run the provisioner without having to
# fully re-create the resource

locals {
  deployment_sentinel_value = {
    certificate_veronica = "0BA76587-7E57-4E7B-85AF-90B43E839502"
  }
}

resource "terraform_data" "certificate_provisioner_veronica" {
  triggers_replace = [
    acme_certificate.veronica.certificate_serial,
    local.deployment_sentinel_value.certificate_veronica
  ]

  connection {
    type            = "ssh"
    user            = "certmgr"
    host            = acme_certificate.veronica.certificate_domain
    target_platform = "unix"
  }

  provisioner "file" {
    content     = acme_certificate.veronica.private_key_pem
    destination = "/etc/ssl/${acme_certificate.veronica.certificate_domain}/key.pem"
  }

  provisioner "file" {
    content     = "${acme_certificate.veronica.certificate_pem}${acme_certificate.veronica.issuer_pem}"
    destination = "/etc/ssl/${acme_certificate.veronica.certificate_domain}/fullchain.cer"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo /etc/init.d/uhttpd restart"
    ]
  }
}
