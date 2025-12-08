resource "tls_cert_request" "veronica" {
  private_key_pem = var.cert_private_key_veronica
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
}
