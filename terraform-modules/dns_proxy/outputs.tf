output "root" {
  value       = "${var.subdomain}.${var.domain}"
  description = "Full-qualified root domain"
  sensitive   = false
}

output "proxy" {
  value       = local.target_domain
  description = "Fully-qualified proxy domain"
  sensitive   = false
}
