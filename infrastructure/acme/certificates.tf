ephemeral "tls_private_key" "veronica" {
  algorithm = "ED25519"
}

resource "tls_cert_request" "veronica" {
  private_key_pem = ephemeral.tls_private_key.veronica.private_key_pem
  dns_names       = ["veronica.${var.domain}"]

  subject {
    common_name = "veronica.${var.domain}"
  }
}

resource "acme_certificate" "veronica" {
  account_key_pem         = acme_registration.letsencrypt.account_key_pem
  certificate_request_pem = tls_cert_request.veronica.cert_request_pem

  dns_challenge {
    provider = "porkbun"
  }

  connection {
    type            = "ssh"
    user            = "certmgr"
    host            = self.certificate_domain
    target_platform = "unix"
  }

  provisioner "file" {
    content     = self.private_key_pem
    destination = "/home/certmgr/ssl/${self.certificate_domain}.key"
  }

  provisioner "file" {
    content     = "${self.certificate_pem}${self.issuer_pem}"
    destination = "/home/certmgr/ssl/fullchain.cer"
  }
}
