resource "acme_registration" "letsencrypt" {
  email_address           = "acme@seanchristians.com"
  account_key_algorithm   = "ECDSA"
  account_key_ecdsa_curve = "P384"
}
