resource "acme_certificate" "veronica" {
  account_key_pem = acme_registration.letsencrypt.account_key_pem
  common_name     = "veronica.${var.domain}"

  dns_challenge {
    provider = "porkbun"
  }
}

# Spearating the resource from the provisioner allows me to use Terraform's
# "replace" method when I need to re-run the provisioner without having to
# fully re-create the resource

locals {
  manual_cert_redeploy_token = {
    veronica = "0BA76587-7E57-4E7B-85AF-90B43E839502"
  }
}

resource "terraform_data" "certificate_provisioner_veronica" {
  triggers_replace = [
    acme_certificate.veronica.certificate_serial,
    local.manual_cert_redeploy_token.veronica
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
