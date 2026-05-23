resource "tailscale_service" "wg_easy" {
  name  = "svc:wg-easy"
  ports = "do-not-validate"
}
