resource "acme_certificate" "veronica" {
  account_key_pem = acme_registration.letsencrypt.account_key_pem
  common_name     = "veronica.${var.domain}"

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
    destination = "/home/certmgr/ssl/${self.certificate_domain}.fullchain.cer"
  }

  provisioner "remote-exec" {
    inline = [
      "/sbin/uci set uhttpd.main.key='/home/certmgr/ssl/${self.certificate_domain}.key'",
      "/sbin/uci set uhttpd.main.cert='/home/certmgr/ssl/${self.certificate_domain}.fullchain.cer'",
      "/sbin/uci commit uhttpd",
      "/etc/init.d/uhttpd restart"
    ]
  }
}
