resource "tailscale_service" "minecraft" {
  name  = "svc:minecraft"
  ports = ["do-not-validate"]

  depends_on = [tailscale_acl.tailnet]
}
